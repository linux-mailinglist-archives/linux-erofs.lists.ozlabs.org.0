Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3EE74D256
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 11:57:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qzztf3BHjz3bV3
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 19:56:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QzztW2mkMz30P3
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 19:56:49 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vn1LFNN_1688983004;
Received: from 30.97.48.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vn1LFNN_1688983004)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 17:56:44 +0800
Message-ID: <ea709cd6-4f82-2c68-3fc6-1ff4291d2241@linux.alibaba.com>
Date: Mon, 10 Jul 2023 17:56:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] erofs: fix to avoid infinite loop in
 z_erofs_do_read_page() when read page beyond EOF
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20230710093410.44071-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230710093410.44071-1-guochunhai@vivo.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/10 17:34, Chunhai Guo wrote:
> z_erofs_do_read_page() may loop infinitely due to the inappropriate
> truncation in the below statement. Since the offset is 64 bits and min_t()
> truncates the result to 32 bits. The solution is to replace unsigned int
> with a 64-bit type, such as erofs_off_t.
>      cur = end - min_t(unsigned int, offset + end - map->m_la, end);
> 
>      - For example:
>          - offset = 0x400160000
>          - end = 0x370
>          - map->m_la = 0x160370
>          - offset + end - map->m_la = 0x400000000
>          - offset + end - map->m_la = 0x00000000 (truncated as unsigned int)
>      - Expected result:
>          - cur = 0
>      - Actual result:
>          - cur = 0x370
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

I'd like to update the subject line manually to:

"erofs: avoid infinite loop in z_erofs_do_read_page() when reading beyond EOF"

since the original one is too long...

Otherwise it looks good to me,

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
