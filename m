Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596D9A1C41D
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2025 16:54:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737820483;
	bh=EEXubCdErB3/wA1Ks8dnJsTV1bGlosJD/TAP1oraC6k=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=aIzfdAeGcStR6vnik5HIFuuBLwLQ3/2c/P0Hiv1h3CPyv+WWeuoQjAk+8cYKsN1Ib
	 WlwhFrv3WapdDxOoCbCVfjVTPzT0exw1W5DlLc/A/GUl7Gav04kBE5xb3cvbfkRQJE
	 uWPbii6mbGYndj3eV7ETQVgb0U949K8rlaJG9z+NjceGofVAUB9+HYZ7cJWgN8vYYc
	 302sFtGYaZDQ4Z64LggIkk9zyTxwenZ85r5XUlI9hIR7/TerlIy1bRJ+McMV1GyCq+
	 DDWYybfZat1f7zIvgvnZKxNXTVtT0ALrYkUCCrONsuDtl6SufTKigYNTDF+B0j+9y5
	 HxhYPuhAwjuzA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YgK4g0hl5z30T7
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Jan 2025 02:54:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737820481;
	cv=none; b=YsjqD08JEPK+pVh0tp35JFAZ5cAimESNbCoZ0NDmvYmsg/6L+VSlOtVLDH530giCge7kDsh66WTnYyUgWWa9+YRjRxuWFveA/4Vuyd+7Fd1GB+UF52O8Oi4XQf1Z/9DWPFl8biro1t/BxA761tgoVDXZT+3prRpEGAE+779g2+if2TxdpvoxstsbOwk+/i3FlXi7qBjcqyicBydKA+G8JDerHsnlV4xmKEZEucIXPjY1gC2CJNRWLNTjYIGv0dsywghCmZ2mfQdAHCXystTWmQR9lvKkEgclbWlFyDr9btXqGzFPT8mjCVx9duhiblKoObNR/fcuJG8UPnp39yG7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737820481; c=relaxed/relaxed;
	bh=EEXubCdErB3/wA1Ks8dnJsTV1bGlosJD/TAP1oraC6k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=APCBI9L714lKhFF7cuVfvkrnDYdQuw5FzFIBGL+nXzr9Aq8lT8JJp2AC81VybZXIzhiRgJ62OJEl+7YMJmBBsgAND7wqioBCi7H2tpB2qQfKRPAPqCsKsJoSjMYY+HYFViSzszCA7MA1EJ5sA7ZP66FdgJBrWA2EP8bWvT2UgAI2Mt40T0PaRWLJmmDecVxJXUIXpVaRF0vUVrxgYC8TPy3pYeR6NOK+Kc6vTIh4ldxKVjId65eJNNt+Vzx8rZ9uD4C4UqmZBfoSs5ymma4HTbwCt0Jy5Bn+tzwlNxku0u4igdhtsj/XjeDRkfQr8U6RECX/4WO0ybJ8ga0fiPDPXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p4bj37LT; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p4bj37LT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YgK4c0DTlz2y92
	for <linux-erofs@lists.ozlabs.org>; Sun, 26 Jan 2025 02:54:39 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9A10DA40DC4;
	Sat, 25 Jan 2025 15:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D515C4CED6;
	Sat, 25 Jan 2025 15:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737820476;
	bh=DHSDIXawuBpWB1i6fSpJXeZ2xjdxcXcvVo4U4dpW2hI=;
	h=Date:From:To:Cc:Subject:From;
	b=p4bj37LTZTq7sXT/srK0LnelQMMU4rJuhDX1plEox7FC2BbPaPESkVRr2Whf90vxi
	 6hjlCuHCCc6n5jeh6LaTHMrpCguUXxH0kAzEvhdJ5S4aaafiwZMeA3Sy4lmXMBCf8M
	 cuUBNmvU6WT4wlOeHIg/P8JiHbyR7qbySaqE843IBBt4lB4khUCQ7FWSWC7TZBR9b/
	 Mvs6KlT+gGrlXsMwKRPrirlF8SvHD0bh8Pooe3qHEZs6Y9xfwjlN5FYJodNjgfPchX
	 Ymz8a/5uU8IigjVER9UrKEEio9FpkH+9Z2oC31a9iBEQKg/sN6bhA8cWazd9m1KrBR
	 Q6jOtlKE2y+eg==
Date: Sat, 25 Jan 2025 23:54:31 +0800
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 6.14-rc1
Message-ID: <Z5UJN5GcunLDlH2h@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>,
	Ethan Carter Edwards <ethan@ethancedwards.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <xiang@kernel.org>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Ethan Carter Edwards <ethan@ethancedwards.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 6.14-rc1?

Still no outstanding feature for this cycle, as some ongoing
improvements remain premature for now.

It includes a micro-optimization for the superblock checksum, along
with minor bugfixes and code cleanups, as usual.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 5bc55a333a2f7316b58edc7573e8e893f7acb532:

  Linux 6.13-rc7 (2025-01-12 14:37:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.14-rc1

for you to fetch changes up to 8f9530aeeb4f756bdfa70510b40e5d28ea3c742e:

  erofs: refine z_erofs_get_extent_compressedlen() (2025-01-23 17:12:11 +0800)

----------------------------------------------------------------
Changes since last update:

 - Micro-optimize superblock checksum;

 - Avoid overly large bvecs[] for file-backed mounts;

 - Some leftover folio conversion in z_erofs_bind_cache();

 - Minor bugfixes and cleanups.

----------------------------------------------------------------
Chen Linxuan (2):
      erofs: return SHRINK_EMPTY if no objects to free
      erofs: remove dead code in erofs_fc_parse_param

Ethan Carter Edwards (1):
      fs: erofs: xattr.c change kzalloc to kcalloc

Gao Xiang (8):
      erofs: micro-optimize superblock checksum
      erofs: shorten bvecs[] for file-backed mounts
      erofs: fix potential return value overflow of z_erofs_shrink_scan()
      erofs: simplify z_erofs_load_compact_lcluster()
      erofs: get rid of `z_erofs_next_pcluster_t`
      erofs: tidy up zdata.c
      erofs: convert z_erofs_bind_cache() to folios
      erofs: refine z_erofs_get_extent_compressedlen()

 fs/erofs/compress.h |  23 +----
 fs/erofs/erofs_fs.h |   3 +-
 fs/erofs/fileio.c   |   4 +-
 fs/erofs/super.c    |  32 +++----
 fs/erofs/xattr.c    |   2 +-
 fs/erofs/zdata.c    | 243 ++++++++++++++++++++--------------------------------
 fs/erofs/zmap.c     | 125 +++++++++++----------------
 fs/erofs/zutil.c    |   2 +-
 8 files changed, 162 insertions(+), 272 deletions(-)
