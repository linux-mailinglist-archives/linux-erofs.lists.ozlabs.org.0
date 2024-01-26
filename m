Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CB783DAD1
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jan 2024 14:30:53 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OD0snhZT;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TLz963Yxcz3dBm
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Jan 2024 00:30:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OD0snhZT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TLz8x52gmz3d9K
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Jan 2024 00:30:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706275832; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KcBBGTYzSlZxLROYC6wPY4xQ8FciqyL6apQ3SBO84Ro=;
	b=OD0snhZTFP0BLinWFSKn+sRbUXk1VHVhhWWLUJ0OF4HYYdpjloAUZ+LJ3yGCGcTlLmg1DVihFfI2LHxSXYgtnsbKbCUwFldRwR1D15ITixSzhDDJAQo91MyCjRq1X5qJNUgG047MoLZvG1lUfKAAyTQr0fpngahQXIa4JxgRxy4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.Nsj5c_1706275826;
Received: from 30.27.78.222(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W.Nsj5c_1706275826)
          by smtp.aliyun-inc.com;
          Fri, 26 Jan 2024 21:30:27 +0800
Message-ID: <5b5387e8-3251-4750-844e-5c34b36eee87@linux.alibaba.com>
Date: Fri, 26 Jan 2024 21:30:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: relaxed temporary buffers allocation on
 readahead
To: Yue Hu <zbestahu@gmail.com>
References: <TY2PR06MB3342D2245C5E515028C33FD4BE792@TY2PR06MB3342.apcprd06.prod.outlook.com>
 <20240126053616.3707834-1-hsiangkao@linux.alibaba.com>
 <20240126184656.0000561c.zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240126184656.0000561c.zbestahu@gmail.com>
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
Cc: Chunhai Guo <guochunhai@vivo.com>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On 2024/1/26 18:46, Yue Hu wrote:
> On Fri, 26 Jan 2024 13:36:16 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 

...

>>   	/*
>> @@ -1276,7 +1280,11 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>>   					.inplace_io = overlapped,
>>   					.partial_decoding = pcl->partial,
>>   					.fillgaps = pcl->multibases,
>> +					.gfp = pcl->besteffort ?
>> +						GFP_KERNEL | __GFP_NOFAIL :
>> +						GFP_NOWAIT | __GFP_NORETRY
>>   				 }, be->pagepool);
>> +	pcl->besteffort = false;
> 
> reposition it following `pcl->multibases = false`?

Good idea! Let me update this.

Thanks,
Gao Xiang
