import unittest
from app import app

class FlaskAppTestCase(unittest.TestCase):
    def setUp(self):
        # 创建一个测试客户端
        app.config['TESTING'] = True
        self.client = app.test_client()

    def test_hello_world(self):
        # 发送GET请求到根路由
        response = self.client.get('/')
        # 检查响应状态码和数据
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data.decode(), 'Hello, World!')

if __name__ == '__main__':
    unittest.main()

