Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C987514FB
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 02:07:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1ZgV5DpTz3byH
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 10:07:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1ZgP3GHVz30XP
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 10:07:43 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VnEWdSj_1689206856;
Received: from 192.168.3.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnEWdSj_1689206856)
          by smtp.aliyun-inc.com;
          Thu, 13 Jul 2023 08:07:37 +0800
Message-ID: <23174b54-b7c6-866a-8e84-f705fc391b4d@linux.alibaba.com>
Date: Thu, 13 Jul 2023 08:07:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] erofs: DEFLATE compression support
To: Randy Dunlap <rdunlap@infradead.org>, linux-erofs@lists.ozlabs.org
References: <20230712233347.122544-1-hsiangkao@linux.alibaba.com>
 <20230712234611.4712-1-hsiangkao@linux.alibaba.com>
 <a2900d12-d90a-b5d3-b158-c079911fdf03@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <a2900d12-d90a-b5d3-b158-c079911fdf03@infradead.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Randy,

On 2023/7/13 08:01, Randy Dunlap wrote:
> 
> 
> On 7/12/23 16:46, Gao Xiang wrote:
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>> index f259d92c9720..d7b5327215f0 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -99,6 +99,21 @@ config EROFS_FS_ZIP_LZMA
>>   
>>   	  If unsure, say N.
>>   
>> +config EROFS_FS_ZIP_DEFLATE
>> +	bool "EROFS DEFLATE compressed data support"
>> +	depends on EROFS_FS_ZIP
>> +	select ZLIB_INFLATE
>> +	help
>> +	  Saying Y here includes support for reading EROFS file systems
>> +	  containing DEFLATE compressed data.  It gives better compression
>> +	  ratios than the default LZ4 format, whileas it costs more CPU
> 
> not a word:                                   whileas

After v2 is sent, I saw your comment then.
Okay, anyway, let me send v3 now.

Thanks,
Gao Xiang
