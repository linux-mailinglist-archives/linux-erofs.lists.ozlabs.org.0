Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 419AD4A2BAA
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jan 2022 05:48:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jm1zx188jz3bSq
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jan 2022 15:48:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jm1zq47Wxz30LP
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Jan 2022 15:48:20 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R331e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V35ILP7_1643431691; 
Received: from B-P7TQMD6M-0146(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V35ILP7_1643431691) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 29 Jan 2022 12:48:12 +0800
Date: Sat, 29 Jan 2022 12:48:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Igor Ostapenko <igoreisberg@gmail.com>
Subject: Re: [PATCH] erofs-utils: fsck: fix issues related to --extract=X
Message-ID: <YfTHCxPDSBARjNn2@B-P7TQMD6M-0146>
References: <YfNvloN0RAX0mHRn@B-P7TQMD6M-0146>
 <20220128160036.101-1-igoreisberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128160036.101-1-igoreisberg@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jan 28, 2022 at 06:00:36PM +0200, Igor Ostapenko wrote:
> From: Igor Eisberg <igoreisberg@gmail.com>
> 
> Fix "--[no-]preserve[-owner/-perms] must be used..." error always thrown
> for superuser when fsck used without --extract=X, due to default values
> for preserve_owner/preserve_perms being already pre-set to true,
> as if the --preserve option was explicitly given by the user.
> 
> Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>

Folded, thanks.
