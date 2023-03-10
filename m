Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F2C6B36AF
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 07:36:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXxC21MYrz3cd9
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 17:35:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXxBy3ZV4z3cB9
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 17:35:53 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VdW4uB6_1678430148;
Received: from 30.97.48.46(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdW4uB6_1678430148)
          by smtp.aliyun-inc.com;
          Fri, 10 Mar 2023 14:35:49 +0800
Message-ID: <b47f5003-c7ad-da27-dab6-077f57aaae18@linux.alibaba.com>
Date: Fri, 10 Mar 2023 14:35:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] ext4: convert to DIV_ROUND_UP() in
 mpage_process_page_bufs()
To: Yangtao Li <frank.li@vivo.com>, tytso@mit.edu, adilger.kernel@dilger.ca
References: <ZArLbO1ckmcXwQf0@sol.localdomain>
 <20230310062738.69663-1-frank.li@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230310062738.69663-1-frank.li@vivo.com>
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
Cc: linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/3/10 14:27, Yangtao Li wrote:
>> Please don't do this.  This makes the code compile down to a division, which is
>> far less efficient.  I've verified this by checking the assembly generated.
> 
> How much is the performance impact? So should the following be modified as shift operations as well?
> 
> fs/erofs/namei.c:92:    int head = 0, back = DIV_ROUND_UP(dir->i_size, EROFS_BLKSIZ) - 1;
> fs/erofs/zmap.c:252:    const unsigned int totalidx = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
> fs/erofs/decompressor.c:14:#define LZ4_MAX_DISTANCE_PAGES       (DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE) + 1)
> fs/erofs/decompressor.c:56:                                     DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
> fs/erofs/decompressor.c:70:     unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
> fs/erofs/data.c:84:     nblocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);

Please stop taking EROFS as example on ext4 patches
and they will all be changed due to subpage support.

> 
> Thx,
> Yangtao
