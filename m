Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3029C63CF19
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 07:07:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NMTJB0ffhz3bNt
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 17:07:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NMTJ73qtgz2xG6
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Nov 2022 17:07:19 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VW1bDq9_1669788434;
Received: from 30.221.128.235(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VW1bDq9_1669788434)
          by smtp.aliyun-inc.com;
          Wed, 30 Nov 2022 14:07:15 +0800
Message-ID: <118bb655-b645-6373-5545-4c0615bf0f74@linux.alibaba.com>
Date: Wed, 30 Nov 2022 14:07:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2] erofs: enable large folios for iomap mode
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20221130060455.44532-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20221130060455.44532-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 11/30/22 2:04 PM, Jingbo Xu wrote:
> Enable large folios for iomap mode.  Then the readahead routine will
> pass down large folios containing multiple pages.
> 
> Let's enable this for non-compressed format for now, until the
> compression part supports large folios later.
> 
> When large folios supported, the iomap routine will allocate iomap_page
> for each large folio and thus we need iomap_release_folio() and
> iomap_invalidate_folio() to free iomap_page when these folios get
> recalimed or invalidated.      ^
  reclaimed


-- 
Thanks,
Jingbo
