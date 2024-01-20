Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD9D8333F1
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Jan 2024 12:53:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4THFJ34Hd1z3byP
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Jan 2024 22:53:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4THFHy2KjJz3bWH
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 Jan 2024 22:53:46 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 0028C10082721
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 Jan 2024 19:53:43 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id AEB5737C9A3
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 Jan 2024 19:53:10 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 0/2] erofs-utils: mkfs: allow to specify dictionary size for compression algorithms
Date: Sat, 20 Jan 2024 19:53:10 +0800
Message-ID: <20240120115310.152240-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106181040.228922-1-zhaoyifan@sjtu.edu.cn>
References: <20240106181040.228922-1-zhaoyifan@sjtu.edu.cn>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patchset allows to specify dictionary size for compression algorithms.

change since v3:
  - remove the third patch as is unrelated to this patchset, will send as a
    separate patch later
  - Now patch 1 and 2 are able to be `git am` without any conflict

Yifan Zhao (2):
  erofs-utils: mkfs: merge erofs_compressor_setlevel() into
    erofs_compressor_init()
  erofs-utils: mkfs: allow to specify dictionary size for compression
    algorithms

 include/erofs/config.h   |  10 ++--
 lib/compress.c           |  37 ++++++++------
 lib/compress_hints.c     |   2 +-
 lib/compressor.c         |  45 +++++++++++------
 lib/compressor.h         |   9 ++--
 lib/compressor_deflate.c |  26 ++++++++--
 lib/compressor_liblzma.c |  34 ++++++++-----
 lib/compressor_lz4.c     |   2 -
 lib/config.c             |   4 +-
 lib/inode.c              |   2 +-
 mkfs/main.c              | 104 +++++++++++++++++++++++++++++++--------
 11 files changed, 197 insertions(+), 78 deletions(-)

-- 
2.43.0

