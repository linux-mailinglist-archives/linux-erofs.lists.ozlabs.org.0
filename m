Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B3E35B14D
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 05:49:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FHyXV62qGz3bTY
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 13:48:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tbc8/VSy;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tbc8/VSy; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FHyXS54ckz30Cy
 for <linux-erofs@lists.ozlabs.org>; Sun, 11 Apr 2021 13:48:56 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53A46610E9;
 Sun, 11 Apr 2021 03:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618112933;
 bh=NcWHQd5IEcqWA9Sh5By7k1kCK+WygOwiAGKoMDSRqWU=;
 h=From:To:Cc:Subject:Date:From;
 b=tbc8/VSysmsQRXn9FB1obrX1zVdhpkW7r+D3xTA2RtVQxkJw+9RT1bEcyE1kvpISi
 gZfi4+N9QfNnYPbKEJqQ8GT7h/tLJRU2/UkYb0O94+9qawu+tEtipB//P1YM+3MH4/
 lSThYkxJA42LEG+a3uUZQMvceXqoRb5qgDe0CBEAOCx0lrGZq8yd1wO3Ncq0VswjrP
 zq86DszN26u5rhdLzNhv6+XrkXQUZcRxeXxf9+EXSdI21Jjz3gEPACNzTdORru808j
 7tIP9DU438Xhej8iKQuj7pm2CFSe+QU7n2mM4mh5GSjxThWHs3XalNDOgKwhjkzFBK
 8FGxL0UsHIFUg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/8] erofs-utils: support big pcluster compression
Date: Sun, 11 Apr 2021 11:48:36 +0800
Message-Id: <20210411034844.12673-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Gao Xiang <xiang@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

This matches big pcluster kernel support in for-next. I've tested
together with ro_fsstress and aosp x86_64 cuttlefish boot without
any problem.

XXX: since LZMA hasn't been introduced yet, compression cfg
generation code is still a preliminary version, will refine it
with later formal LZMA support.

Thanks,
Gao Xiang

Gao Xiang (7):
  erofs-utils: introduce ondisk compression cfgs
  erofs-utils: add -C# for the maximum size of pclusters
  erofs-utils: add big physical cluster definition
  erofs-utils: fuse: support multiple block compression
  erofs-utils: mkfs: support multiple block compression
  erofs-utils: fuse: support compact indexes for bigpcluster
  erofs-utils: mkfs: support compact indexes for bigpcluster

Huang Jianan (1):
  erofs-utils: support adjust lz4 history window size

 include/erofs/compress.h |   2 +-
 include/erofs/config.h   |   2 +
 include/erofs/internal.h |   5 ++
 include/erofs_fs.h       |  39 ++++++++--
 lib/compress.c           | 160 ++++++++++++++++++++++++++++++---------
 lib/compressor_lz4.c     |   5 ++
 lib/compressor_lz4hc.c   |   2 +
 lib/config.c             |   1 +
 lib/data.c               |   4 +-
 lib/zmap.c               | 136 +++++++++++++++++++++++++++++----
 mkfs/main.c              |  21 ++++-
 11 files changed, 317 insertions(+), 60 deletions(-)

-- 
2.20.1

