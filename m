Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD946C515
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 04:55:44 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45pzKB0qjCzDqMp
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 12:55:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45pzK64trVzDqLH
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2019 12:55:38 +1000 (AEST)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7ECA542EA92E0ADA71C6;
 Thu, 18 Jul 2019 10:55:32 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 18 Jul
 2019 10:55:25 +0800
Subject: =?UTF-8?B?UmU6IGVyb3PmgKfog73pl67popg=?=
To: ZHOU <353779207@qq.com>
References: <tencent_43D5609D92443B9ED755C87B7843FA71D705@qq.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <d3efd7a5-c781-6163-d04a-c2e6382ea760@huawei.com>
Date: Thu, 18 Jul 2019 10:54:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <tencent_43D5609D92443B9ED755C87B7843FA71D705@qq.com>
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/7/18 10:47, ZHOU wrote:
> Dear sir or madam,
> 
> �0�2
> 
> �ܸ�л��Ϊ�͹��Ŷӽ�erofs��Դ�������ǳ���л���ǵĸ����͹��ס�
> 
> �0�2
> 
> �������ҿ���erofs���룬��ѡ����һ��android pƽ̨��qcom sdm429���0�2kernel 4.9, �0�2emmc5.1����Ϊ��ֲ��
> 
> ѡ����ֲ��Դkernel�汾��4.19��Ŀ��汾4.9��mkfsѡ���֧mkfs-dev��
> 
> ��ֲ�����������xattr��capability�����ԣ������Ѿ��������豸���������С�
> 
> �0�2
> 
> ���ܲ��ԣ�
> 
> ���Թ���ѡ��iozone���޸�iozone����д���ݲ������Σ������ݲ�У�飬Ȼ�󴴽�һ��������ݲ����ļ���
> 
> ����erofs�У���������Ϊ��./iozone -i 2 -s 300m -r 4k -+E -w -f ./vendor/tmp_file

�Ҳ�����������ʲô��˼���Ƿ��ж�Ӧ��fio�����

> 
> ��������������ϣ�������ѹ�����ǲ�ѹ������ext4�����ڽϴ���죺
> 
> vendor�������ԣ�
> 
> ext4 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�226113
> 
> erofs no compress�0�2�0�2�0�2�0�2�0�2�0�2�0�2�0�2�0�2�0�2�0�2 �0�2 �0�220970

�޷���ⲻѹ���Ĳ��죬�����Ƿ�ʹ����direct I/O��erofs��֧��direct I/O��

лл��

> 
> erofs cp 4 ratio �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�221485
> 
> erofs cp 100 ratio�0�2�0�2�0�2�0�2�0�2�0�2�0�2�0�2�0�2�0�2 �0�2 �0�2�0�2 19949
> 
> f2fs��userdata���0�2�0�2�0�2�0�2�0�2�0�2�0�2�0�2�0�2�0�2�0�2�0�2 �0�2 �0�2 32766
> 
> �0�2
> 
> loop���ԣ������ļ�ֱ�ӷ���userdata��mount��tmpĿ¼����
> 
> ext4 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�2 �0�229561 �0�2 30318�0�2 29531
> 
> erofs cp 20 ratio�0�2 �0�2�0�2 30525 �0�2 30630�0�2 30037
> 
> �0�2
> 
> ��˳������棬erofs��ext4û�����Բ��졣
> 
> �0�2
> 
> Ŀǰ����������������������ext4����������滹���ڲ�࣬����Ӧ�ô��ķ���ȥ�Ż�?
> 
> �0�2
> 
> �ǳ���л��
> 
> �0�2
> 
> --�0�2
> 
> Thanks & Regards,
> 
> hengguo.zhou�0�2�ܺ��
> 
