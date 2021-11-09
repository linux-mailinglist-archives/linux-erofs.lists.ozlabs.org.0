Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F351F44A532
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 04:10:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpCfS6kMKz2yQH
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 14:10:40 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpCfK3cchz2yHP
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 14:10:28 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UviXRY0_1636427418; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UviXRY0_1636427418) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 09 Nov 2021 11:10:20 +0800
Date: Tue, 9 Nov 2021 11:10:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH 1/2] erofs: add sysfs interface
Message-ID: <YYnmmla6xh5Y4d30@B-P7TQMD6M-0146.local>
References: <20211109025445.12427-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211109025445.12427-1-huangjianan@oppo.com>
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
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org, yh@oppo.com,
 guanyuwei@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Tue, Nov 09, 2021 at 10:54:44AM +0800, Huang Jianan via Linux-erofs wrote:

You might need to add a "From:" tag here, otherwise, the author will
show "Huang Jianan via Linux-erofs" due to your mailing server...

> Add sysfs interface to configure erofs related parameters in the
> future.

s/in the future/Later/

> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
>  fs/erofs/Makefile   |   2 +-
>  fs/erofs/internal.h |  10 ++
>  fs/erofs/super.c    |  12 +++
>  fs/erofs/sysfs.c    | 239 ++++++++++++++++++++++++++++++++++++++++++++

At a quick glance, we might need to add sysfs API documentation
as well:
Documentation/ABI/testing/sysfs-fs-erofs

Thanks,
Gao Xiang

