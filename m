Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F24FC44AC84
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 12:21:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpQYK6bTyz2yPT
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 22:21:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpQYG3rfkz2xv8
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 22:21:53 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UvmuAzv_1636456893; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UvmuAzv_1636456893) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 09 Nov 2021 19:21:34 +0800
Date: Tue, 9 Nov 2021 19:21:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Guo Xuenan <guoxuenan@huawei.com>
Subject: Re: [PATCH v3 1/5] erofs-utils: add support for the full
 decompressed length
Message-ID: <YYpZvIYX8aXt6V54@B-P7TQMD6M-0146.local>
References: <20211029091244.1162119-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211029091244.1162119-1-guoxuenan@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org, mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Oct 29, 2021 at 05:12:40PM +0800, Guo Xuenan wrote:
> From: Huang Jianan <huangjianan@oppo.com>
> 
> Previously, there is no need to get the full decompressed length since
> EROFS supports partial decompression. However for some other cases
> such as fiemap, the full decompressed length is necessary for iomap to
> make it work properly.
> 
> This patch adds a way to get the full decompressed length. Note that
> it takes more metadata overhead and it'd be avoided if possible in the
> performance sensitive scenario.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Gao Xiang <xiang@kernel.org>

The series has been applied with some clean-up work.
