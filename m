Return-Path: <linux-erofs+bounces-815-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213EAB2535F
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Aug 2025 20:55:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c2Hct5CbRz30Qk;
	Thu, 14 Aug 2025 04:55:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755111326;
	cv=none; b=Zmi6IHg401mC/PlMyzpIaP9WWKm1jvLvgd2nz0nMxZLLUmsv+55X0ZibuJIfbTGQha/PELI7/hHWxMiuqtmGqi8eb7/NlAt/wdXh/kC48Y6H59a8gZ1c2q5vM1K5isXCNYaxX9v36owQSSkhHSGggvOKXlXkfiu0iQARzIdpsd/FuwMZCmcnHmAm1l85b4PIXLDdFCK7gGFcuIjN+ytRoMzk7AzFA23nPR8JRjtJR8LaN12Ax0T0upYvV2Y9E0Vixa1NDOLytXVB10EoKtRWWRlSuM5k0tUwF/HKvVJoDJaIZFkahGn0WKBZ82C+aXHTktZZJFQi0QOO39PZaAPhMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755111326; c=relaxed/relaxed;
	bh=LbLKc3PwunnhPryDM5LTuFIXc7grPJ5dzsgkNucg+1Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MSa4yIVem5+om5hV+/5ZNh7/KnhF7GKl9U5D9KomYOdVMrwFLOxSEAouCRKIVzewxCS2woVdsoNa1cNc0NbwNAejT2N3kNCOKucrInQyz8czE+v+SrszS5LaHSkQnDd1HmAxjHhBXnnAZ6gbvtElCm6ph5Ce8qdjl663ygjGRGf3p98luRQ2nUpS21G9ID/dA37AwwVlfSBItqAzaaPfJB311F1O1+pclXcbG1HiOD82T5/q7m2qm1P2Trp1UrB2awnDGU4bEi/W0ZTa63UE50AOzo4MPpPMnxZicTOKl/NIbIT73ISnfU020evWeoOZR+qzquhNSYfLi/71r8wVZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tdlaPt5O; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tdlaPt5O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=pr-tracker-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c2Hcs6t1mz2xcD
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Aug 2025 04:55:25 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 40AF75C4821;
	Wed, 13 Aug 2025 18:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8179C4CEEB;
	Wed, 13 Aug 2025 18:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755111323;
	bh=pTGCk3bS3OknouKmVzlKeIj5BTjrRJrgUL/s3EauJ3k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tdlaPt5OM+sM5GH+5ANMMX4JoAc6fO0/98FtNY8di9SFHIoG8to71rvF2Gr25OQLh
	 sVb8P4vGTALh8MWP6O/muLL/QcjNnOobOM6sUmkEGZNHjoYoaVB0759TRJcsHY775C
	 w2ZVCrHVjFJ8QFqZerC5IO7niO31hsZ+rXEryhnl9g61r6eOAIEBPkl5sfkTU+OB19
	 ua3Ov1h+97a7UyrV3sYBqcvCP3blNbkzEpqI7txSpvIggKnLyRSC3qFpnp9xztTBa0
	 MiV25g10nuXBIKkmZSvWLbeFvSztNqdGVD1ur5xghogGoQV9t3SQTjEsdsqp6FKNsX
	 8r3CW/e0GiRmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B3C4139D0C37;
	Wed, 13 Aug 2025 18:55:36 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aJzUQt58S0ZEv0zn@debian>
References: <aJzUQt58S0ZEv0zn@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aJzUQt58S0ZEv0zn@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc2-fixes
X-PR-Tracked-Commit-Id: 0b96d9bed324a1c1b7d02bfb9596351ef178428d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dfc0f6373094dd88e1eaf76c44f2ff01b65db851
Message-Id: <175511133541.3709535.13181225643804638997.pr-tracker-bot@kernel.org>
Date: Wed, 13 Aug 2025 18:55:35 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Yuezhang Mo <Yuezhang.Mo@sony.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Junli Liu <liujunli@lixiang.com>, Chao Yu <chao@kernel.org>
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list

The pull request you sent on Thu, 14 Aug 2025 02:06:58 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dfc0f6373094dd88e1eaf76c44f2ff01b65db851

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

