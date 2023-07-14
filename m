Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8608C7534DE
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 10:16:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R2PSs3P0vz3c5l
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 18:16:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R2PSn3xTkz2yHT
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 18:16:24 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VnL2dZw_1689322576;
Received: from 30.97.49.6(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnL2dZw_1689322576)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 16:16:17 +0800
Message-ID: <080ecea0-ef51-11f3-0b64-7c5272946d87@linux.alibaba.com>
Date: Fri, 14 Jul 2023 16:16:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/4] erofs-utils: add DEFLATE compression support
To: linux-erofs@lists.ozlabs.org
References: <20230710110251.89464-1-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230710110251.89464-1-hsiangkao@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/10 19:02, Gao Xiang wrote:
> Hi folks,
> 
> This is the EROFS DEFLATE support which I've been working on these
> months, mainly implementing DEFLATE fixed-sized output approach.  Note
> that it's still some room to improve but I introduce it just to avoid
> external outdated zlib dependencies and the basic zlib encoder.
> 
> DEFLATE is a popular generic-purpose compression algorithm for a quite
> long time (many advanced formats like zlib, gzip, zip, png are all
> based on that), which is made of LZ77 as wells as Huffman code, fully
> documented as RFC1951 and quite easy to understand.  DEFLATE encoder
> and decoder are also easy to be implemented and they generally have
> fairly small code size and runtime memory consumption.
> 
> In addition, there are several hardware on-market DEFLATE accelerators
> as well, such as (s390) DFLTCC, (Intel) IAA/QAT, (HiSilicon) ZIP
> accelerator, etc.  Therefore, it's useful to support DEFLATE in order
> to use these for async I/Os and get benefits from these later.
> 

I will apply this patchset since these patches work fine on my side
and do incremental development if there are some further improvements.

Thanks,
Gao Xiang
