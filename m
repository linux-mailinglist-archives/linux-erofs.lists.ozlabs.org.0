Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AE26C9E7
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 09:22:21 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45q5Dn2P7qzDqGv
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 17:22:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45q5Dg4V9czDqCq
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2019 17:22:11 +1000 (AEST)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5F9C6F4AF73ED5EDABB5;
 Thu, 18 Jul 2019 15:22:06 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 18 Jul
 2019 15:21:59 +0800
Subject: =?UTF-8?B?UmU6IOWbnuWkje+8muWbnuWkje+8muWbnuWkje+8muWbnuWkje+8mg==?=
 =?UTF-8?B?5Zue5aSN77yaZXJvc+aAp+iDvemXrumimA==?=
To: ZHOU <353779207@qq.com>
References: <tencent_E808F13AAE9BDE391B1E8F73AECBEB542408@qq.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <6c6ec4f9-0ba5-fb31-84ce-fbf70d95fe01@huawei.com>
Date: Thu, 18 Jul 2019 15:21:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <tencent_E808F13AAE9BDE391B1E8F73AECBEB542408@qq.com>
Content-Type: text/plain; charset="gb18030"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs <linux-erofs@lists.ozlabs.org>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/7/18 15:13, ZHOU wrote:
> Dear Gao xiang,
> ͨ��fio���ԣ����ָ�cpu�����й�ϵ��Ĭ�ϵ�Ƶ������erofs��������ext4������Ƶ���Ե�����performance ģʽ����ʱerofs���ʽ�ext4��һЩ��


���ȷʵ����֣��ǲ���erofs�Ĳ�ѹ��ģʽ���߼��Ƚϼ�cpu loading���أ����ᴥ��
android��CPU��Ƶ���������ļ�ϵͳ�����߼��Ƚϸ������״���CPU��Ƶ���Ƿ��������
�о�һ�¹����½����


�����ࡣ���⣬��pc����lz4�Բ����ļ�����ѹ�������ּ�������ѹ����Ӧ���ǲ����ļ�ѡ����Ҳ�����⡣����ʹ�þ��нϴ�ѹ���ԵĲ����ļ������ٲ��ԡ�
> 
> Thanks
> B.R
> 
> 
> ------------------ ԭʼ�ʼ� ------------------
> *������:* Gao Xiang <gaoxiang25@huawei.com>
> *����ʱ��:* 2019��7��18�� 11:56
> *�ռ���:* ZHOU <353779207@qq.com>
> *����:* Miao Xie <miaoxie@huawei.com>, linux-erofs <linux-erofs@lists.ozlabs.org>
> *����:* �ظ����ظ����ظ����ظ����ظ���eros��������
> 
> 
> 
> On 2019/7/18 11:53, ZHOU wrote:
>> iozone �Ķ���С��ֻ����openʱѡ��O_RDONLY, Ȼ������-+Eѡ��ʹ�ö������ļ���ֻ������
> 
> ��֮������fio������������������֤��ͬ��LBA����һ�²�ѹ�������ֲ�ѹ����������Һ��ɻ�
> Ҳ����û�κα�Ҫȥ��һ�����ͣ�����ļ���ʲô�������
> 
>>
>> ��л֧��
>> B.R
>>
>>
>>
>>
>>
>>
>> ------------------ ԭʼ�ʼ� ------------------
>> *������:* Gao Xiang <gaoxiang25@huawei.com>
>> *����ʱ��:* 2019��7��18�� 11:46
>> *�ռ���:* ZHOU <353779207@qq.com>
>> *����:* Miao Xie <miaoxie@huawei.com>, linux-erofs <linux-erofs@lists.ozlabs.org>
>> *����:* �ظ����ظ����ظ����ظ���eros��������
>>
>>
>>
>> On 2019/7/18 11:39, ZHOU wrote:
>>> �õģ���config CONFIG_EROFS_FS_ZIP_CACHE_BIPOLAR �Ѿ������˵ġ�
>>> ����ʱѡ��ͬһ̨�豸������һ�£�ʹ��loop��ʽerofs��ext4��࣬������ϸ���һ��LBA��
>>
>> loop��ʽ���岻�󣬲�֪��iozone����ô�ĵģ�Ҳ��֪�����ǵ��ں��Ƿ��ext4�иĶ���
>> �Ҿ�����������ñ�׼��fio��һ�£�����Ҫ���κ��޸ģ�mkfs�б�ҪҲ����ʹ��ԭʼ���룬ͨ���������������ԡ�
>>
>>>
>>> лл�����Ľ���
>>>
>>> B.R
>>>
>>>
>>>
>>>
>>>
>>> ------------------ ԭʼ�ʼ� ------------------
>>> *������:* Gao Xiang <gaoxiang25@huawei.com>
>>> *����ʱ��:* 2019��7��18�� 11:28
>>> *�ռ���:* ZHOU <353779207@qq.com>
>>> *����:* Miao Xie <miaoxie@huawei.com>, linux-erofs <linux-erofs@lists.ozlabs.org>
>>> *����:* �ظ����ظ����ظ���eros��������
>>>
>>>
>>>
>>> On 2019/7/18 11:24, ZHOU wrote:
>>>> �ǵ� ����������erofs����� ��Ӧ�ó������ܶ񻯵����� ��������xattrʱ����û������share�ķ�ʽ������android��Ӧ�ò���Ӱ�쵽���ܰɣ���Ϊ�ڶ�security���Ժ�Ỻ�浽kernel��
>>>
>>> û�У��Ҿ����������Ų����Լ����Ե�����������Ƿ��android�ں˵ĵ��������йأ������ǿ��Լ�log�Ų飬
>>> ���⽨�����ʹ����ͬ��LBA�����ұ������ǰд�����������ݣ������flash����ͬ��LBA��ֱ�Ӳ��ԣ���
>>> �������ѹ����Ӧ������˵�������ѹ��������config��Ҫ����CONFIG_EROFS_FS_ZIP_CACHE_BIPOLAR
>>>
>>>>
>>>> B.R
>>>>
>>>>
>>>> ------------------ ԭʼ�ʼ� ------------------
>>>> *������:* Gao Xiang <gaoxiang25@huawei.com>
>>>> *����ʱ��:* 2019��7��18�� 11:19
>>>> *�ռ���:* ZHOU <353779207@qq.com>
>>>> *����:* Miao Xie <miaoxie@huawei.com>, linux-erofs <linux-erofs@lists.ozlabs.org>
>>>> *����:* �ظ����ظ���eros��������
>>>>
>>>>
>>>>
>>>> On 2019/7/18 11:15, ZHOU wrote:
>>>>> Dear xiang,
>>>>> û������directIO,
>>>>> �õ�,�ҳ���һ�����ṩ�Ĳ��Է�����
>>>>
>>>> ���ٶ��ڲ�ѹ����������������������в��졣
>>>>
>>>> лл��
>>>>
>>>>>
>>>>> �ǳ���л
>>>>>
>>>>>
>>>>> ------------------ ԭʼ�ʼ� ------------------
>>>>> *������:* Gao Xiang <gaoxiang25@huawei.com>
>>>>> *����ʱ��:* 2019��7��18�� 11:10
>>>>> *�ռ���:* ZHOU <353779207@qq.com>
>>>>> *����:* Miao Xie <miaoxie@huawei.com>, linux-erofs <linux-erofs@lists.ozlabs.org>
>>>>> *����:* �ظ���eros��������
>>>>>
>>>>>
>>>>>
>>>>> On 2019/7/18 10:54, Gao Xiang wrote:
>>>>>>> ����erofs�У���������Ϊ��./iozone -i 2 -s 300m -r 4k -+E -w -f ./vendor/tmp_file
>>>>>> �Ҳ�����������ʲô��˼���Ƿ��ж�Ӧ��fio�����
>>>>>>
>>>>>
>>>>> ���⣬���ǽ���������pattern��Ҳ�����ǲ��Թ�ע�ģ���
>>>>> echo 3 > /proc/sys/vm/drop_caches
>>>>> ./fio --readonly -rw=randread -size=100% -bs=4k -name=job1
>>>>>
>>>>> ��Ϊ�������Ӧ��û��direct I/O����û��direct I/O��·��������û��direct I/O֧�ּƻ���
>>>>> Ҳ������ʹ��direct I/O�������ܡ�
