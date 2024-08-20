Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B658958F65
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 23:01:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724187706;
	bh=8VEc/HOqkE0fk1j7DVg8hej65QBN4H0HeHsJSBg2DvQ=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=AGr4zrGi9RdI562WeTsOCEzghdZk56mRfzB4UWrbXST8d13f8nYLaTsVbtT48PHRZ
	 duvT99Qz4XPjpJyxs3EyA2kZdvhwliAvcjB03MjN7AOnT+Gh2zhTMLjWAifKJ9i42a
	 +3NBFwCEtJMJCscjzbVLNKiL8wttcgHR+l8aQuqz9DL8c8KWCLxpkO0/Nj79J8f870
	 9riUXSPna7TdVgmT4G4qtGlkuemAzEupnmOVypqxdPgvdxBvwiKHDCdQqrodNgBY6o
	 zjD4nDCtUEr082TxnBmsGqk29TVyQ4E24qtaO6dv556NPBDlnsxdlvu/34FZN8udTY
	 qWr/ahw3Bh80A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WpMMt4MhPz2yWr
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 07:01:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::114a"
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=qEoxMXoB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::114a; helo=mail-yw1-x114a.google.com; envelope-from=3lgtfzgckc4cosl6lwprzzrwp.nzxwty58-p2zq3wt343.zawlm3.z2r@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WpMMm5Nh9z2y33
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2024 07:01:39 +1000 (AEST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-6b41e02c255so73369577b3.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2024 14:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724187694; x=1724792494; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8VEc/HOqkE0fk1j7DVg8hej65QBN4H0HeHsJSBg2DvQ=;
        b=qEoxMXoBOAke7W9cmt5txfPsNVqi9UJ/lFt+L0xx3MP2PHB0pue8XBXeCLP3uWRbxS
         8Cn+q4RHNN2VaDCRppD88hN3F9106RbnFRisiCZJlq4I/LdnzVvPVf/PCCpbpEZ79UD0
         U2W0tpcQsNuyIgKzMcWibqIyGKwVSAkN548HqmTWLNR9equx4HaMpLGPVEBlSgje/IdX
         9+rYd8oFzBkBCQrjt7yAzvGxOCos0ZM9oOTPlbyeLbS9Cp0ibFXKRAJqnFAjPCsXHgPS
         YDkcLcUIfSvyEuxLpGPPFxo84KiDxas+CAH6inFavQ00e51I5/mN7QvrK4VTAWX7QJmI
         VJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724187694; x=1724792494;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8VEc/HOqkE0fk1j7DVg8hej65QBN4H0HeHsJSBg2DvQ=;
        b=SAsVfse1WepYz4S0RWUqWKotjYT2l2opJMC13mokG6eCUUEOhAqVryUrb1SVNw0UcJ
         qNvJ7mm5rpg05eQywXzfkpXik+EKBBdoR6cMiRFBHlk5LeTF/uhqiHjq9z409w0Z7wSr
         4/U+BVvLyjEREhqAbcQcRefFhaYuAIxr4pYarl/Nc5bQhVzYP+9Pl0cmWP9ZV/dGmtP3
         fajVKBVbl4w5gF1EvDJ2EcdrBHMur0fn3fSzQJQ5jHJqPKkkFxOvgxrr3W1Fqmhz5St4
         9YZiAaAEEhh6D+K34sBl0eu0QR97/x8JnYd7IIhYQ22zhuWpYBgNxaaZ6X9MDha8nr/E
         /vvQ==
X-Gm-Message-State: AOJu0Yy/8L+uSavFMUcnEgYpa6x5vXR0QPWMrYlztlwWiWk2Qy1GO6aM
	rgrzAkTAcJxne+UR/xohyJDj59e87XKyfqlwrZVlouAeqbABfTQjDQ1MgOKQlSDF48e8zjd+o7o
	J/WbT2TjfFOggTPmyOwePF1sdeHPKAsC3VdV1msWg8fPGC8ZdsairwI7SqhvnCKinse3zg5nuEx
	r3HeEp2Cy2W+GY9MNapX1Oigqcwpv1n702nCURDK/QjurHCQ==
X-Google-Smtp-Source: AGHT+IHvYAc+hV3rDC7Mpwx31wOQb+AftRlX2Qs1RLY2ClSL6ZhsybzxhEbrWhCh4Zfac45Ie8ke6JLLr3ie
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:d58e:af88:2a92:d1b3])
 (user=dhavale job=sendgmr) by 2002:a05:6902:3c7:b0:e0b:f684:e972 with SMTP id
 3f1490d57ef6-e16657b65b4mr7514276.12.1724187694284; Tue, 20 Aug 2024 14:01:34
 -0700 (PDT)
Date: Tue, 20 Aug 2024 14:01:22 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240820210123.2684886-1-dhavale@google.com>
Subject: [PATCH 0/1] Improve handling of unidentified xattrs
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,
I had a report that when erofs is built from the btrfs filesystem with
compression enabled, it would fail to build seemingly with error
"failed to build shared xattrs". We tried to fix this by returning 0 
(null) instead of error in parse_one_xattr(). However we need to
actually skip it else we get a null pointer dereference in 
erofs_xattr_add() trying to process the same.

Thanks,
Sandeep.

Tested with btrfs with compression enabled.
$ lsattr mtpt/
--------c------------- mtpt/sample.txt

Before:
mkfs.erofs -z lz4hc,9 erofs.img mtpt/
mkfs.erofs 1.8.1-dirty
<W> erofs: parse_one_xattr() Line[285] skipped unidentified xattr: btrfs.compression
Segmentation fault

After:
mkfs.erofs -z lz4hc,9 erofs.img mtpt/
mkfs.erofs 1.8.1-dirty
<W> erofs: parse_one_xattr() Line[285] skipped unidentified xattr: btrfs.compression
Processing sample.txt ...
<W> erofs: parse_one_xattr() Line[285] skipped unidentified xattr: btrfs.compression
Build completed.
------
Filesystem UUID: 9a1bb5a3-077a-40bc-972f-ed141059e7c8
Filesystem total blocks: 5 (of 4096-byte blocks)
Filesystem total inodes: 2
Filesystem total metadata blocks: 1
Filesystem total deduplicated bytes (of source files): 0 

Sandeep Dhavale (1):
  erofs-utils: lib: actually skip the unidentified xattrs

 lib/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.46.0.184.g6999bdac58-goog

