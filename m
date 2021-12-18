Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA2C479849
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Dec 2021 04:03:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JG9f154Wzz305j
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Dec 2021 14:03:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JG9ds1fFxz2ypK
 for <linux-erofs@lists.ozlabs.org>; Sat, 18 Dec 2021 14:03:10 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R861e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V-xH.vx_1639796569; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V-xH.vx_1639796569) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 18 Dec 2021 11:02:50 +0800
Date: Sat, 18 Dec 2021 11:02:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Igor Eisberg <igoreisberg@gmail.com>
Subject: Re: erofs-utils: fix consistency + add NUL after root path
Message-ID: <Yb1PWF+TSVIrZdMo@B-P7TQMD6M-0146.local>
References: <CABjEcnET1aCa7yA3Vyk8RCBKK0d0wR_iPezr=N2jp6jRx6EB6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABjEcnET1aCa7yA3Vyk8RCBKK0d0wR_iPezr=N2jp6jRx6EB6w@mail.gmail.com>
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

Hi Igor,

On Sat, Dec 18, 2021 at 04:35:37AM +0200, Igor Eisberg wrote:
> From 8b209620abfbd8147a2c771cb0126dcca528e34f Mon Sep 17 00:00:00 2001
> From: Igor Ostapenko <igoreisberg@gmail.com>
> Date: Sat, 18 Dec 2021 04:30:17 +0200
> Subject: erofs-utils: fix consistency + add NUL after root path
> 
> Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>

Thanks for these catches! If you don't mind, I've folded these
into corresponding patches.

Thanks,
Gao Xiang
