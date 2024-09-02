Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B89339681EF
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 10:31:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725265916;
	bh=oKPn+zD0eRJIX/o2vrVRDLstxl6jl9/PbkerZfe7CPw=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=XkiHpZ4j68DzIroNvcnPVpKmA/CTC18Jp5qAOAMJ66yhrVwXAQcdp93NaEiiGexm8
	 c4D9rmEkYV3efblB/Bzf6h/q3WDlltMHxQSPMZP2+v5kZCs2zJ7oOc08+oGnLQzPEQ
	 cJaBIXg0It3W9cxGBDB29JFehx1fZdX6UkKptImRuap4SzJ7Won09efaLTwKcc89ze
	 mAwNHU/gfXmLghbhb3cp5pc3CitMEImjaeVbbhzYfJdvvpQaHVlqCiwpQIhD48UQcb
	 cr6qrg3/TEnDUiMCuGz/yE7o+7pInhpmac5eNAdsLOB6yt+Ksz9AMkO9BlP9uZXotf
	 GMqYPikHCK7tw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy26h5Prnz2yJ9
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 18:31:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725265914;
	cv=none; b=QAYt6+cgEZ5+xKE7y+n50uTudOGVcoGsLPGztrhdzSwbFKUFOk+Lyp4Mu5kumoWZM92OH2dBn8b0QJ5nOsWqK7FfvWVosCLyTr27WCVux2x2zbFlFnS2Ibz4ZRWLJuZ+cN+9vU6MjvBIhP2jeC+dGJY8rK0fOmx33SbZjG6uxXWad/mekheskUpWOU57V+cY5guJLP7k1yHbXZFqXT28q0hv1iLj6MmDsKfl5kgMLBpFaT8k4OoqHD+ymQvqLCFAi2M3rupmPcw+TaUjvJDt4XkV2bWJGNfjbuAfF+yvXWezA2Chi6F+rzgdIUAxTGFdIgbxFxVkW9LYAl0CmTFJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725265914; c=relaxed/relaxed;
	bh=oKPn+zD0eRJIX/o2vrVRDLstxl6jl9/PbkerZfe7CPw=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version; b=flhuiTHHN11v2TLEsYLm+rP2XpkE8Gl8ZSdUJzFdjQiHDFiOJUR414X8QgbgIlptgwXAPqG2TDVUfFnmrSp1ZPwMFmnUo3z47yF09cl6KhfIvhes1i/tgErI+Ld9iHb3ctLFKYKPd7/1lIWOmongdSnd29/qw9GzfTjoCOYyBOMv04SiUsAMKcnzxuVPRM8LeziVXdSP+DxUoP3329URyzLmBwfo4pqllRQzHAsaP+nPybr9WUFjKSE0FkcOkA8pGcn/eLRGhBhpEa70y54Wp66Undg9D9yV0wd/TZ3YN/5VrrafTXEexBjZhBvKMVG+ReK6f+aOGa0nKvuVMPcrhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=mvN5keBm; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=mvN5keBm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy26f4nTpz2xWb
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 18:31:54 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 164C869838;
	Mon,  2 Sep 2024 04:31:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725265913; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=oKPn+zD0eRJIX/o2vrVRDLstxl6jl9/PbkerZfe7CPw=;
	b=mvN5keBm9kXvDGR+Ls/tCOgV6wqsrc9lZUmsdhUAaK1FtEVrlgip8O9TxS/nQIdG32Mwh6
	R/vjDB4sHLMwhvUXWi/MS0lay4Uu2s/tQb5AulDBwaUZh63mpAhylgLzdMedkFXRP3StDA
	dvjRmOTnYDbSbCmmopR1CJU4aYoQ+7s4GlkIXexATl8czT9yCSYjxQX79ARHOSnTAXdXCx
	4ntmCQ9e7luqx+lAD4v5t3R/dMpL3SuFESXkRdRnlt7TwxG+Vkzjx4gGf16UvNOyhGn6e+
	m6qGK3KWqSw6/he+fF+BRRDjo1UCCQPpumntPnF0VPMrVYHZKGqFT+z5AKBiuQ==
To: hsiangkao@linux.alibaba.com
Subject: [PATCH V4 0/2] erofs: refactor fast_symlink and read_inode
Date: Mon,  2 Sep 2024 16:31:45 +0800
Message-ID: <20240902083147.450558-1-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patchset is response to the original suggestions posted here[1].
Since my later work is somehow related to this issue, i think it's
better to deal with it first.

Changes in V2:
  1. Lift the erofs_fill_symlink patch to 1/2
  2. Fix code styles problems in read_inode patch.
  3. Fix the formatting problems caused by clang-format.

Changes in V3:
  1. Remove some redundant variables and statements in both patches.

Changes in V4:
  1. Remove out_unlock in erofs_fill_inode and use early returns.
  2. Fix missing initializer for erofs_buf in erofs_read_inode.

[1]: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/

Yiyang Wu (2):
  erofs: use kmemdup_nul in erofs_fill_symlink
  erofs: refactor read_inode calling convention

 fs/erofs/inode.c | 133 ++++++++++++++++++++++-------------------------
 1 file changed, 61 insertions(+), 72 deletions(-)

-- 
2.46.0

