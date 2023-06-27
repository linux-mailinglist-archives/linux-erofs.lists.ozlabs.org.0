Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BE873FD0B
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 15:43:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qr5XV0XDqz30Kg
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 23:43:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qr5XL71Zvz2ykB
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jun 2023 23:43:45 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vm692cC_1687873416;
Received: from 192.168.3.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vm692cC_1687873416)
          by smtp.aliyun-inc.com;
          Tue, 27 Jun 2023 21:43:38 +0800
Message-ID: <a7a26d3e-937f-9877-46e1-1713e7726986@linux.alibaba.com>
Date: Tue, 27 Jun 2023 21:43:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs-utils: fsck: add support for extracting hard links
To: Yue Hu <zbestahu@gmail.com>
References: <20230627085332.27974-1-zbestahu@gmail.com>
 <1867cbe7-184a-2847-fa7a-d01ccd2f72f2@linux.alibaba.com>
 <20230627211144.0000229b.zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230627211144.0000229b.zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/6/27 21:11, Yue Hu wrote:
> On Tue, 27 Jun 2023 17:47:33 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 

...

>>> +
>>> +	if (!fsckcfg.extract_path || erofs_is_packed_inode(inode)) {
>>
>> why introducing erofs_is_packed_inode here?
> 
> hardlink hashtable will be initialized after verify packed inode.

we could initialize it before verifing packed inode.

Thanks,
Gao Xiang
