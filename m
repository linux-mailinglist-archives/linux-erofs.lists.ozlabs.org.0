Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5673B4271D9
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Oct 2021 22:09:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HQzmM1JX9z30D0
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Oct 2021 07:09:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ss4BtCT8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ss4BtCT8; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HQzmF1nTsz301k
 for <linux-erofs@lists.ozlabs.org>; Sat,  9 Oct 2021 07:09:01 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4976061019;
 Fri,  8 Oct 2021 20:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633723737;
 bh=KmFExuavQRUuydLea0+sQnpoCrziI5QQDHZyRBAlaRk=;
 h=From:To:Cc:Subject:Date:From;
 b=ss4BtCT858+oMIVNCW5FkfXH8WqCytzMnSLRG/Gu0wLcVbXOu5sNrmaUevj/uHJ75
 iZxvxzQsulresQ48q4G3EalGeuN8XoproPlEAGEtULugSKasLWUyxeMeaJxQxYaGV1
 lMTGpbOjqMmUgbAqPSvMzhhjBWbnqKn+zV88Bl+IQv1wWugO2mSw5nYxipI7GqeiYz
 Bw8BclYABXtTRF8A5uGaDI+em5pi+Ad3pUsElcTDb+Qit3sPQygXdcu2kXIu+ObYOk
 sE+j20C5fExvX3cung6DW4Nc9R1yccOofKD87N7mN4b2stt/ps5euQqQDvCez1wgzO
 bdx6NI0H76pWg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 0/3] erofs: some decompression improvements
Date: Sat,  9 Oct 2021 04:08:36 +0800
Message-Id: <20211008200839.24541-1-xiang@kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

This patchset is mainly intended for the upcoming LZMA preparation,
but they still have some benefits to the exist LZ4 decompression.

The first patch looks up compression algorithms on mapping instead
of in the decompression frontend, which is used for the rest patches.

The second patch introduces another compression HEAD (HEAD2) so that
each file can be compressed with two different algorithms at most,
which can be used for the upcoming LZMA compression and LZ4 range
dictionary compression for different data/access patterns.

The third patch introduces a new readmore decompression strategy
trying to improve randread for large LZ4 big pcluster and the upcoming
LZMA decompression. It mainly addresses the previous issue mentioned
in the original big pcluster patchset [1]:

FIO randread
Testdata: enwik9
Kernel: Linux 5.15.0-rc2

pclustersize		Vanilla		Patched
 4096			 54.6 MiB/s	 56.1 MiB/s
16384			117.4 MiB/s	145.6 MiB/s
32768			113.6 MiB/s	203.4 MiB/s
65536			 72.8 MiB/s	236.1 MiB/s

The latest version can also be fetched from
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git -b erofs/readmore

[1] https://lore.kernel.org/r/20210407043927.10623-1-xiang@kernel.org

Thanks,
Gao Xiang

Changes since v1:
 - correct the function name to z_erofs_map_blocks_iter() in the commit
   message pointed out by Yue;

 - fix the readmore logic which mainly impacts the LZMA approach later,
   therefore test the Patched version again.

Gao Xiang (3):
  erofs: get compression algorithms directly on mapping
  erofs: introduce the secondary compression head
  erofs: introduce readmore decompression strategy

 fs/erofs/compress.h          |   5 --
 fs/erofs/erofs_fs.h          |   8 ++-
 fs/erofs/internal.h          |  25 +++++++-
 fs/erofs/zdata.c             | 111 +++++++++++++++++++++++++++--------
 fs/erofs/zmap.c              |  55 +++++++++++------
 include/trace/events/erofs.h |   2 +-
 6 files changed, 151 insertions(+), 55 deletions(-)

-- 
2.20.1

