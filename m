Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AF76B5E96
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Mar 2023 18:18:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PYqPr3X9Rz3cKb
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Mar 2023 04:18:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s8OT6kPJ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s8OT6kPJ;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PYqPh0NtZz3bcN
	for <linux-erofs@lists.ozlabs.org>; Sun, 12 Mar 2023 04:18:15 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3828B60C86
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Mar 2023 17:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C74C433D2;
	Sat, 11 Mar 2023 17:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678555091;
	bh=OqMHq2/S6nAUuvpkSIGBYmiSX+aQtkh+hYs7nV9aLEI=;
	h=Date:From:To:Cc:Subject:From;
	b=s8OT6kPJKT1xtyIsRrDQ+LjUM3V8x1e/6BqcRhy1UW1TZ9tugHrmpL+P5T2goYtne
	 FywDg5MxH00TSQDo6bEQW75lMYeQZwIwslb0vBr/bpa01GP9iNYWLKtCfMizqaGS4d
	 OyrhoigZYi1gdRueBH7bblQcBxknVBHLvbTe7PaRmZ4SWZ5H44eMJnuUkEb4Zrbz6h
	 KIB0ng9/eExMi5xTCEB1njrBBApJJx18Lx6wXebfiBFLEzOXUYXOK5ldyRBrDmVcA5
	 Y1KeTG7CqXpWz3YIPRz6JYcEPDqb3juUQwTAJDOzfwaDzObPSdmW/rHNJ6xLXww5Jp
	 IDGqDD4dYhBkw==
Date: Sun, 12 Mar 2023 01:18:05 +0800
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [ANNOUNCE] erofs-utils: release 1.6
Message-ID: <ZAy3zaoCulNNpFSS@debian>
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

A new version erofs-utils 1.6 is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git tags/v1.6

It mainly includes the following changes:

  - support fragments by using `-Efragments` (Yue Hu);
  - support compressed data deduplication by using `-Ededupe` (Ziyang Zhang);
  - (erofsfuse) support extended attributes (Huang Jianan);
  - (mkfs.erofs) support multiple algorithms in a single image (Gao Xiang);
  - (mkfs.erofs) support chunk-based sparse files (Gao Xiang);
  - (mkfs.erofs) add volume-label setting support (Naoto Yamaguchi);
  - (mkfs.erofs) add uid/gid offsetting support (Naoto Yamaguchi);
  - (mkfs.erofs) pack files entirely by using `-Eall-fragments` (Gao Xiang);
  - various bugfixes and cleanups.

This new version supports global compressed data deduplication
(`-Ededupe`) and fragments (`-Efragments`, `-Eall-fragments`), which
can be used to minimize image sizes further (Linux 6.1+).  In addition,
mkfs.erofs now supports per-file alternative algorithms, thus different
configurations can be applied in a per-file basis (Linux 5.16+).

There are also other improvements and bugfixes as always.  Kindly read
README before trying it out.  Recently I've got many useful inputs, so
it's time to release erofs-utils 1.6 as soon as possible and move on
to focus on those new stuffs (e.g. negative xattr lookup improvement
with bloom filters, shared xattr names and tarball reference) then.

Finally, as a community-driven open source software, feedback and/or
contribution is always welcomed.

Thanks,
Gao Xiang
