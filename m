Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE64536FCD
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 07:55:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L9nnp4lgCz3bkq
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 15:55:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pQoXMVRP;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pQoXMVRP;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4L9nnh6rzgz303t
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 May 2022 15:55:20 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 75ADCB8074C;
	Sun, 29 May 2022 05:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3731CC34119;
	Sun, 29 May 2022 05:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653803715;
	bh=H52FMjaGR3TckVvkXZ+DeEnK4PrDJ0ytTMGlgH8OYUA=;
	h=From:To:Cc:Subject:Date:From;
	b=pQoXMVRPUiy1F+Q4V/u1diZEFbGNnKBdiPeFyDt6V2FeY5CVZ4/bmfMjTJEqWk2OK
	 ZNnU3xVEDwgKBXAnI3hz7bfMZBXKZtbUfti6yIgC9k841vU2CZERlPAT73VH4tO6zK
	 4USJjLQxzcdUiq9yQLfmXZEBX7xlWCWCTMutvHpxorAKreGShLmJCjR5lHuqu97aRr
	 BzCqGSpiWK2B0RVnHl3S5FaCupev8TLtrkn4lW81wSadL3vzYGUmnulAI7IYupyk9M
	 NYcYqG3Kc4TPIPtx+gXngJocqPM16aWa/ItYR9K50aphWzZD7+T3uKLqnLcfcXuxq4
	 ZJZh7QBJPg/LQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 0/3] erofs: random decompression cleanups
Date: Sun, 29 May 2022 13:54:22 +0800
Message-Id: <20220529055425.226363-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Hi folks,

Now I'm working on cleanuping decompression code and doing some
folio adaption for the next 5.20 cycle, see:

https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/folios

This cleanup work completely gets rid of PageError usage finally
and tries to prepare for introducing rolling hashing for EROFS
since EROFS supports compressing variable-sized data instead of
fixed-sized clusters.

Therefore, EROFS can support rolling hash easily and our mechanism
can make full use of filesystem interfaces (byte-addressed) naturally.

Before that, I'd like to submit some trivial cleanups in advance for
the 5.19 cycle. All patches are without any logical change, so I can
have a more recent codebase for the next rework cycle.

Thanks,
Gao Xiang

Gao Xiang (3):
  erofs: get rid of `struct z_erofs_collection'
  erofs: get rid of label `restart_now'
  erofs: simplify z_erofs_pcluster_readmore()

 fs/erofs/zdata.c | 165 +++++++++++++++++++----------------------------
 fs/erofs/zdata.h |  50 +++++++-------
 2 files changed, 88 insertions(+), 127 deletions(-)

-- 
2.30.2

