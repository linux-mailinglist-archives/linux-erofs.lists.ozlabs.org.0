Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324153B2610
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Jun 2021 06:13:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G9RZ95NjXz3068
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Jun 2021 14:13:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G9RZ55DM7z2yWn
 for <linux-erofs@lists.ozlabs.org>; Thu, 24 Jun 2021 14:13:00 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R261e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04420; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UdTva9G_1624507963; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UdTva9G_1624507963) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Jun 2021 12:12:44 +0800
Date: Thu, 24 Jun 2021 12:12:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Li Guifu <bluce.lee@aliyun.com>
Subject: Re: [PATCH] AOSP: erofs-utils: add block list support
Message-ID: <YNQGOlhaB3milCDj@B-P7TQMD6M-0146.local>
References: <20210622030232.1176-1-zbestahu@gmail.com>
 <258e86ca-c9f4-0df1-8af9-6fd445bd4982@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <258e86ca-c9f4-0df1-8af9-6fd445bd4982@aliyun.com>
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
Cc: Yue Hu <zbestahu@gmail.com>, huyue2@yulong.com, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org, zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jun 23, 2021 at 11:58:15PM -0400, Li Guifu wrote:
> Hu Yue
> 
>   Thanks to your contribution.
>   Base test shows it could record block map list correctly.
>   Some codes need be refactored for further ahead.

Guifu,
could you check my v2 as well?
https://lore.kernel.org/linux-erofs/1624469489-40907-1-git-send-email-hsiangkao@linux.alibaba.com

does it look good to you?

Thanks,
Gao Xiang

