Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B04B65CD9A
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 08:28:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nn1S463f7z3bTJ
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 18:28:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nn1S04K1Wz2yPD
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Jan 2023 18:28:48 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VYqimyD_1672817323;
Received: from 30.97.49.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VYqimyD_1672817323)
          by smtp.aliyun-inc.com;
          Wed, 04 Jan 2023 15:28:44 +0800
Message-ID: <99d24ef5-c72a-80ea-9ea5-2b7e1e60af79@linux.alibaba.com>
Date: Wed, 4 Jan 2023 15:28:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC PATCH] erofs-utils: fsck: support fragments
To: Yue Hu <zbestahu@gmail.com>
References: <20221224094319.10317-1-zbestahu@gmail.com>
 <fa1df3e5-9158-4381-5315-d243f77542a6@linux.alibaba.com>
 <20230104112445.000075d8.zbestahu@gmail.com>
 <5236b19c-763f-9a5b-a0c1-4c59fa7c6d05@linux.alibaba.com>
 <20230104152651.000051df.zbestahu@gmail.com>
From: Xiang Gao <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230104152651.000051df.zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/1/4 15:26, Yue Hu wrote:

...

>>
>> I think we could just export parts of erofs_pread() to clean up the
>> whole erofs_verify_inode_data()...
> 
> What's the clean up referring to?
> 
> However, i think erofs_verify_inode_data() looks a little duplicate compared to erofs_read_raw_data/z_erofs_read_data().

We should reuse the main part (for example, by introducing an interface 
to accept mapping) of
erofs_read_raw_data() and z_erofs_read_data() to avoid duplicated code 
in erofs_verify_inode_data().

Thanks,
Gao Xiang

> 
>>
>> Thanks,
>> Gao Xiang
>>
>>
