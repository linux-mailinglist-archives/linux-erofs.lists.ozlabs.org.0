Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9227DFB0E
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Nov 2023 20:41:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SLvQP21mJz3dBX
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Nov 2023 06:41:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lukeshu.com (client-ip=104.207.138.63; helo=mav.lukeshu.com; envelope-from=lukeshu@lukeshu.com; receiver=lists.ozlabs.org)
Received: from mav.lukeshu.com (mav.lukeshu.com [104.207.138.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SLvQF3pWHz3cVq
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Nov 2023 06:41:41 +1100 (AEDT)
Received: from lukeshu-thinkpad-e15 (unknown [IPv6:2601:281:8200:4f:aee0:10ff:fe55:8023])
	by mav.lukeshu.com (Postfix) with ESMTPSA id 0D09B80623;
	Thu,  2 Nov 2023 15:31:41 -0400 (EDT)
From: "Luke T. Shumaker" <lukeshu@lukeshu.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/3] erofs-utils: Address doc and flag-parsing snags
Date: Thu,  2 Nov 2023 13:31:19 -0600
Message-ID: <20231102193122.140921-1-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.42.0
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
Cc: "Luke T. Shumaker" <lukeshu@umorpha.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "Luke T. Shumaker" <lukeshu@umorpha.io>

Hi all,

This patchset addresses snags that I hit while adopting erofs for our
system images.

 - The first patch is really just setting a baseline for the next two.

 - The second patch is improving the --help text to address the snag
   that I had to read the source code to understand how to use the
   mkfs.erofs `-z` flag, and also setting the stage for the third
   patch.  In doing this I broadly improved the --help text overall,
   not just for mkfs.erofs.

 - The third patch is adding no-op `-a`, `-A`, and `-y` flags to
   fsck.erofs, to address the snag that I was seeing errors in the
   boot scroll.

I didn't touch erofsfuse in any of these, not because it isn't worthy
of the changes from the first two patches, just that I decided it
would have been too much work at the moment.

Luke T. Shumaker (3):
  erofs-utils: have each non-fuse command take -h, --help, -V, and
    --version
  erofs-utils: improve the usage and version text of non-fuse commands
  erofs-utils: fsck: Add -a, -A, and -y flags

 dump/main.c              |  47 +++++++------
 fsck/main.c              |  81 ++++++++++++++--------
 include/erofs/compress.h |   2 +-
 lib/compressor.c         |  13 +---
 lib/compressor.h         |   9 ++-
 man/dump.erofs.1         |   5 +-
 man/fsck.erofs.1         |   8 ++-
 man/mkfs.erofs.1         |  15 ++--
 mkfs/main.c              | 144 +++++++++++++++++++++++++--------------
 9 files changed, 202 insertions(+), 122 deletions(-)

-- 
Happy hacking,
~ Luke T. Shumaker
