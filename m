Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D7694C799
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Aug 2024 02:28:43 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ulg63fX3;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wg4X85HFJz2yWy
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Aug 2024 10:28:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ulg63fX3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wg4X21yB4z2xCj
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Aug 2024 10:28:34 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5F102CE13C5
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Aug 2024 00:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379B9C32782;
	Fri,  9 Aug 2024 00:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723163310;
	bh=j7acfRmWN8a8RIUIMSOekjkgzrtuHbzOe0P51lahgZw=;
	h=Date:From:To:Cc:Subject:From;
	b=ulg63fX3EbQGQNuLeccth32BOSnsq27MAYDmw9ss10IlQqo+IySmhDspOzs0/+U4U
	 jtBE71A+RPcxIZZmoPgZz0EltuxNM0QDXm+Xp65M1DnAe68BlMnOxMljwtDWogU4H+
	 f72+n87jL/IoOTLZ5VgQ/jV6HPw7K13zzEBo6aWT9L8pvzxB64d5jGU7r/v6XFoNge
	 6M3AorT1XF+eG4J3PSvuu/2KNkaQ7dkC6W0obbnr8uUwqcTx5NGD2jPEndnDRjzSda
	 q0NiOj9jMGWBsXm8iAt5o3znVlD9X5OOGyhYMy2lg5S7yY3izvhKWo6eegP3SE2kIZ
	 9G04ZcYr1uM1Q==
Date: Fri, 9 Aug 2024 08:28:24 +0800
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [ANNOUNCE] erofs-utils: release 1.8
Message-ID: <ZrViqMFpC6uVEoXK@debian>
Mail-Followup-To: linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

A new version erofs-utils 1.8 is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git tags/v1.8

It mainly includes the following changes:

   - (mkfs.erofs) support multi-threaded compression (Yifan Zhao);
   - support Intel IAA hardware accelerator with Intel QPL;
   - add preliminary Zstandard support;
   - (erofsfuse) use FUSE low-level APIs and support multi-threading (Li Yiyan);
   - (mkfs.erofs) support tar source without data (Mike Baynton);
   - (mkfs.erofs) support incremental builds (incomplete, EXPERIMENTAL);
   - (mkfs.erofs) other build performance improvements;
   - (erofsfuse) support building erofsfuse as a static library (ComixHe);
   - various bugfixes and cleanups (Sandeep Dhavale, Noboru Asai,
           Luke T. Shumaker, Yifan Zhao, Hongzhen Luo and Tianyi Liu).

It has been long time since the last release, mainly due to several new
major features and limited incremental builds.  However, it'd be better
not to hold it off any longer, as users have asked for multi-threaded
mkfs support.

In the future erofs-utils versions, we are going to improve incremental
builds, support multi-threaded mkfs for fragments and compressed data
deduplication, multi-threaded fsck/extraction as well as more remote
storage (e.g. HTTP, S3 and OCI registries), stabilize liberofs APIs for
3rd-party applications and eventually find a way to integrate a Rust
version [1].  Also see [2].

Feedback and contribution, as always, are welcomed.

[1] https://github.com/ToolmanP/erofs-rs
[2] https://erofs.docs.kernel.org/en/latest/roadmap.html

Thanks,
Gao Xiang
