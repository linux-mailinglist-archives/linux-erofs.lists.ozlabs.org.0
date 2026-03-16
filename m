Return-Path: <linux-erofs+bounces-2768-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFeWJt53uGn5dgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2768-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 22:36:30 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 056C82A106C
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 22:36:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZT1Q6NfCz2xb3;
	Tue, 17 Mar 2026 08:36:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::830"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773696986;
	cv=none; b=NQYH5+QEeqoYiXU1h6/XWb344RtHA+yLMii6cIuOVNPGEMPMSObMxpPbA59x/N3nro7GsZlbabWRZqF/QqQ8FA1/9v6crfMHD+Xu7FhdN54wvG1veC9Szf8ghiMoZ4yA1rsKMjHmLKbrqNrJjLWsiqgyVKN28+jtjqioE6DHd1H90nBZkLEQM8teDLAJqa2COuXo9h0+D1bV/54NpRWGNklExHS7LP4EDRO84W8h4wM/cWtJBvMBjv1RhSgQqzQyuthAdfM/DUN9Owvkg212ZEmXdxO1fAIhTWIzDn7F06KHkKeQlV5Ga5PnPDT7wCvylNhYGr6VLN5Pm+/1d+U7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773696986; c=relaxed/relaxed;
	bh=UuAmGgbfl+JV2g5jci7AOV5QImEZLcznAUEhETM+f8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KQrJGlT4hX+WlECh0NfGjvx4GG9s6T6sq5/rJtDhOVeTO0KOcCwrIqsgM2wBksqV+IQUuTtFZdte67UrHrR4n7I4QyidRl768oTGo58PSHfVCgRVXsEyWMflbD7OcKJTI7c/l2KAen/cy3J7ItELQ1hXkbFEYieG7q0SqQSfkArxzH02TTsBpHWtvAHo5mDD8anA9Z72naX6/2Mi2Nhb1v7N50zzGFlBDn9JY6ajADCi4IhKHyVFjKIU2t4GNO4vnaLwg3FbK9fm7GwTB56o2R5lRRaxbn9kccFuZqfdxRT1xzEED1jktZEa4Es/0mDWiiDan984r2hSrcR+OuQnbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IrTr7vxx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IrTr7vxx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZT1P0RfTz2xQB
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 08:36:23 +1100 (AEDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-509064418a8so60983171cf.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 14:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773696981; x=1774301781; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UuAmGgbfl+JV2g5jci7AOV5QImEZLcznAUEhETM+f8o=;
        b=IrTr7vxxFNc6F1SHM9X1iVRMa2izdlY5NK85TVfEkg7JWyGggFYRPCfs0TuvyiC27z
         Fn33I0dhZxx1kmogCT9KWUDi+vIiGYFbHhO46a69QwS3clxeRojDv4G3lLk0YSIkJoIQ
         0HwiZ4O/0ICj7deh+9sAuDpS8RFkmmoThzv4MS3PDl4mm+5BR540J2dqAFRTUXQ6d/ac
         WXDO1Ol9e4SItDfyz9h0rFm7aFcj+JNH/DYyoTwcq2XdOkZwW1QxWGVOZECPAP6KBOkQ
         t2ns6sD4xu7Qvp0y35AD9Nxs91n3seBrGxqnQC4PTPxyKmWx4zIF9KOkGbRUJ3T+CWwQ
         cDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696981; x=1774301781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuAmGgbfl+JV2g5jci7AOV5QImEZLcznAUEhETM+f8o=;
        b=bL/Dbsiel+P4/RsI1lY3QoAlBnBc3K68BiZsVYSV4RIGTedPJ0JmHMw5fhjVdYfWQL
         OLxy8v2YWsxtdfuKSWjyl60do4TlSNsbCAwY1+YiJ4BW6z7u1gnF2sToNnu/7KtEMdQy
         Il0iN73sgBNfuZnIeiN10fCv1+ps16K+3+PwUTKKfGBCrwRyx3+gJ+yv3o2FXwnGmOxa
         jpxIpPaL2EhHZ7jR//t/F0nBuQnQz2HlDrPo6DoMLvb6xmToliTbEccnxnSvwb9iIT8/
         IEhWt8d7JjzYiP8eygxXgI0VeBRZ1/jNpbTa+TDHWCQf6OMObCnbr4WvaJ4jj6mZrA7G
         4cRA==
X-Forwarded-Encrypted: i=1; AJvYcCUx4PirfPFecuFaPlY3lyglZmQOH1ePcOZTAWLw7UTrcJG5+XgGKKyDUtJ0W+wrGVqftXamsU88bDpVXw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YylNPzQ484BT1XyYX12OmM7aUSC5xH9bfFv4M0FwUqWmj+st4ZS
	G37rJkgSH5O9RqKoX9sI30M+3OPkUbgFLFJedlJKgLqON1cBSz1XqgojBIq7OE5S7Q==
X-Gm-Gg: ATEYQzxL8+q6tKXFEWDTG1ccJh6xxhtzWWNZGuLcFFZuSxTbpzdKFPa1kXU39RxVvrU
	3a2LkFX2mOra5hYxEPskl3LsJs76VDry4yf0dXwD5Qgk61VPMKI7UAoVTwEsQYEiFKQ2Nw1mlpT
	l4aXaK1nkr16LjKAH+Id8MLn0T9a3jWgpyObjf5y5XzurIt+6UBIh0WMpMCvHA9vPJ/quiAwtV5
	v6RRlDk9sDMoGBXiY9CBZRHtBsVfrq3Dl0BINOGUDFwMUoUxSKKe6mVbwL5JTdmt0f7bpBBunUF
	c1GIV9rrvMCfhLxjQ1j4pwWcqg7DiYCr3jOaKiu3g4+0nOx7h6t+6fVZMVD4U3REEE2fKwx5cUs
	bMo+nE1j7kgTzr39O6vae28OwVvDYWe7G9eb2L2PPEDLOGs+JannnftebMbmHjTa+T+70R69Bef
	8XR4GoSqrNPIett2ruIC20H74x2W3r9S3eBtufDBxmTfa4E4ZyYJT8NNBhnSmOmpHIpU0d
X-Received: by 2002:a05:622a:199d:b0:509:99c:2cbc with SMTP id d75a77b69052e-50957e1106cmr194434801cf.63.1773696981096;
        Mon, 16 Mar 2026 14:36:21 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5094a03556csm105356641cf.2.2026.03.16.14.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:36:20 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>
Subject: [PATCH 0/3] Fix incorrect overlayfs mmap() and mprotect() LSM access controls
Date: Mon, 16 Mar 2026 17:35:55 -0400
Message-ID: <20260316213606.374109-5-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-2768-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 056C82A106C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing mmap() and mprotect() LSM access control points for the
overlayfs filesystem are incomplete in that they do not cover both the
user and backing files.  This patchset corrects this through the addition
of a new backing file specific LSM hook, security_mmap_backing_file(),
a new user path file associated with a backing file that can be used by
LSMs in the security_file_mprotect() code path, and the associated
SELinux code changes.

The security_mmap_backing_file() hook is intended to allow LSMs to apply
access controls on mmap() operations accessing a backing file, similar to
the security_mmap_file() for user files.  Due to the details around the
accesses and the desire to distinguish between the two types of accesses,
a new LSM hook was needed.  More information on this new hook can be
found in the associated patch.

The new user path file replaces the existing user path stored in the
backing file.  This change was necessary to support LSM based access
controls in the mprotect() code path where only one file is accessible
via the vma->vm_file field.  Unfortunately, storing a reference to the
user file inside the backing file does not work due to the cyclic
ref counting so a stand-in was necessary, the new user O_PATH file.
This new O_PATH file is intended to be representative of the original
user file and can be used by LSMs to make access control decisions based
on both the backing and user files.

The SELinux changes in this patchset involve making use of the new
security_mmap_backing_file() hook and updating the existing mprotect()
access controls to take into account both the backing and user files.
These changes preserve the existing SELinux approach of allowing access
on overlayfs files if the current task has the necessary rights to the
user file and the mounting process has the necessary rights to the
underlying backing file.

--
Amir Goldstein (1):
      backing_file: store user_path_file

Paul Moore (2):
      lsm: add the security_mmap_backing_file() hook
      selinux: fix overlayfs mmap() and mprotect() access checks

 fs/backing-file.c             |   28 +++++---
 fs/erofs/ishare.c             |   12 ++-
 fs/file_table.c               |   53 +++++++++++++---
 fs/fuse/passthrough.c         |    3 
 fs/internal.h                 |    5 -
 fs/overlayfs/dir.c            |    3 
 fs/overlayfs/file.c           |    1 
 include/linux/backing-file.h  |   29 ++++++++-
 include/linux/file_ref.h      |   10 ---
 include/linux/lsm_audit.h     |    2 
 include/linux/lsm_hook_defs.h |    2 
 include/linux/security.h      |   10 +++
 security/security.c           |   25 +++++++
 security/selinux/hooks.c      |  108 ++++++++++++++++++++++++++++------
 14 files changed, 231 insertions(+), 60 deletions(-)


