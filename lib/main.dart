import 'package:flutter/material.dart';
import 'utils.dart'; // Import file chứa hàm calculateBMI

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter BMI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double? _bmi;
  String? _bmiMessage;

  void _calculateBMI() {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height != null && weight != null) {
      try {
        setState(() {
          _bmi = calculateBMI(height, weight); // Sử dụng hàm calculateBMI
        });

        if (_bmi! < 18.5) {
          _bmiMessage =
              'Chỉ số BMI của bạn dưới 18,5: Bạn đang gặp phải tình trạng thiếu cân, vì thế nên áp dụng các phương pháp ăn uống và luyện tập để tăng trọng lượng cơ thể.';
        } else if (_bmi! >= 18.5 && _bmi! <= 24.9) {
          _bmiMessage =
              'Chỉ số BMI của bạn là 18,5 đến 24,9: Bạn đang sở hữu cân nặng khỏe mạnh, cần duy trì quá trình ăn uống và sinh hoạt như thường ngày.';
        } else if (_bmi! >= 25 && _bmi! <= 29.9) {
          _bmiMessage =
              'Chỉ số BMI của bạn là 25 đến 29,9: Bạn đang trong tình trạng thừa cân, cần áp dụng thực đơn ăn kiêng hợp lý cùng việc luyện tập khoa học để lấy lại vóc dáng chuẩn nhất.';
        } else {
          _bmiMessage =
              'Chỉ số BMI của bạn từ 30 trở lên: Bạn đang bị béo phì và tình trạng này có thể khiến bạn gặp rất nhiều vấn đề về sức khỏe cũng như trong sinh hoạt.';
        }

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_bmiMessage!)));
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://i.pinimg.com/474x/10/40/fc/1040fc568fe329d75cf6edd6195ea337.jpg',
            ),
            fit: BoxFit.cover, // Để hình ảnh phủ toàn bộ màn hình
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Height (cm)',
                  border: OutlineInputBorder(),
                  filled: true, // Để làm nổi bật TextField trên nền
                  fillColor: Color.fromARGB(179, 255, 255, 255), // Màu nền của TextField
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Weight (kg)',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(179, 255, 255, 255),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _calculateBMI,
                child: const Text('Calculate BMI'),
              ),
              const SizedBox(height: 16),
              if (_bmi != null)
                Text(
                  'Your BMI is: ${_bmi!.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: const Color.fromARGB(255, 255, 255, 255), // Màu chữ để dễ đọc trên nền
                  ),
                ),
              if (_bmiMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    _bmiMessage!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color.fromARGB(255, 252, 252, 252), // Đổi màu chữ thành màu đen
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
