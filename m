Return-Path: <linux-erofs+bounces-3185-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNuyAl4vz2k3tgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3185-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 05:09:18 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7FA3909A3
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 05:09:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn3bX2t40z2yhG;
	Fri, 03 Apr 2026 14:09:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f36"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775185752;
	cv=none; b=Omv7t3W8KLVXN9PuRtntLAo2dQ3j7b2uSkmifHw+zIIeeUXoymZnceOSMXbIEAM0ySgk54s5UtJ8IGTkBQrphWhku/V2VQRgNkpfcR7KCONCgQ54OUXp87h49XAmGXe9p+yJz+ryabItpiI+M+H9IyF7HJuk5j7l4hbs+JYatIbaL4JHVPP9EiV871K944Sq/umB8OsJTlu+jjA8xpk8s1KhfW6+fb5KFTs/CNXrHmgr9EpD+wyDdDcKrIprMmZrRpLHu3vjPaGH4VBmEbsiJbfUhBANZLGEwPCCZF9ltEH93oG0pduAh8uEDWSpXBXRDvXZlbkaZFHwo+AxOdOkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775185752; c=relaxed/relaxed;
	bh=Q+R/8MkRE1msWS32ANzMTpmj3lRg9zDjBRK7qW9MA9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XyHhJJ98tquJAQH2kSolY+DVBsXk/WYESiUmvHx5FPvdb9pmT4dlWiV/tTjarR6D+uLw6+SqPuft0/3bX9fyhArWyyPOf2nzxtMM8VIaRhkjMfuuNg8XJ0njBPQn4KV0zGuT1XURDVKuqUnU70dJeU2HamMvujsL1E8ukik3dWEqDF26znDx4EbVp663XspaVAHPiqQ6tJCqvpCuNt27R40gM75MjkojshqljPVmoHP7EHIont5XjYg+yL6DHMIshdVEDxXpxq+zc8meKHZOVcyo5ldhddDkp61kd1tupVMG8072bS4UEFHm1JNWEu6UYLheSeIn0iqcuaiodDlL6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XdZAFAov; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XdZAFAov;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn3bV3zqmz2xLt
	for <linux-erofs@lists.ozlabs.org>; Fri, 03 Apr 2026 14:09:09 +1100 (AEDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-89fc349b5ceso24598996d6.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 20:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775185746; x=1775790546; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+R/8MkRE1msWS32ANzMTpmj3lRg9zDjBRK7qW9MA9g=;
        b=XdZAFAovCwMuz2l2lz1XXuVGSkvRp4GS7T3GQovP/pNrfGLE93UTLWnArSupR7FLWy
         8SRB4zxRSSKD7zF6qg1rnfK29YUUhLSOPxogb+I+frStname+3puBsZbKsKxHXy0gIe1
         TLEl12TDHJWLj/EYh0L/je+ADA+TRv1+2kV6IOd2U31gOuHWHQNzJEjv4SgFqNXz9daW
         kAE/L9DqexDCCdK5lfOstfMXdjuUFI33V3ArlCcjZ9QLVQ2z9iCpAzZUBHIyIdfvOAFs
         EsvyIBHDza+8kxIiglF+TW3fffPjyp4t2pKVrwqHwR88JM9Pf4f3sfm3DKHI1K5pbDjY
         VKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775185746; x=1775790546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+R/8MkRE1msWS32ANzMTpmj3lRg9zDjBRK7qW9MA9g=;
        b=WFwRx7NnOZqIJATADXf3iIN+UJyJlsQNEYvg9IGeoTgr4nXd+/eOVxMsO6jxl9BDnP
         t/+zBKOe+qS52h8Z1rYgjGgpfpcFs7iRPKAHFT+wBrhnh/bZ6/O2svpOn7dGl0RZnl+v
         NUr0pY/Yr1SIamsPMv7zwAcyCGXQVP8r36YJ99xkLGwtPUBH9DscSvoJa7sh83QmxET6
         Z3/VfqxKS0bsjM0PrNzJw7CS+cnC7Nt1jQmXosChQfYERLpQp8UUOAosWGy9Es70tXoE
         UVj71U/QmCuCYUnNkZHnOd3lZmwNw07byxjK9p5I8MuIFELkmT/0Nl3HZg7C8YurzB9r
         M57Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAWQz/s21yPsTel5tsvZsWjXxbUlCuUZSaV+UTxx1BYVb3llHhVd0P9PrclaphgiKSfH6R3KZyfZGx8w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwHK1RIpm5oWB+A9Gtwk2PNOCdms9yUI3JWgUCdx2iOxH1oiEy2
	0CH9p3urKZf+6l82DwlaUBPEFuZP1X/yaPwRYKVgWH/L6hNNUVENyRQBnXSsNPivkw==
X-Gm-Gg: AeBDievr54uTc53DYUlOHlw6vZxJZQwPyTR0UnnXKRgaZcypeE4nlY7cAVk+3s7co+k
	7oK0MXUykE+SpM2dVdLnebkpE1s4U5CZC/aU5WQISA31G/tvw4SYZ3en14FXikWol/AC7ESjvnP
	hkNl80pHqc7u0ElWbNCcWdlBbBPikGAiUdQuNMDL38RwOwrNZljYJtUYADx275HBN3kNUHNvTw8
	mi5D7cvBvkAPeHsUsdih+fXmisZDjYy7GGn/y6HjS0gzbmgsGXMH/+qMVM8AlLV5d5cXT6++vmC
	06g4D/6uKyUi29JumnEzaPBU2xtwfe+bVPkiKP70/RhGeh6SgcGSkQPB7oRzaQnd9FZAH5wNqg+
	71LcgK8SdN/GW7fDpWNyaxOpJdLm9KT8icIk5s/1PjWKZ4xJaenafF7k/8tFbhEe0djklth/UeY
	emWtX5q7+9hCeFwbBG8pPeGQiraVLFbFqe2ctw2o95FWpvMT2obBH3adxD83yTPKl51Urr
X-Received: by 2002:a05:6214:2b0b:b0:8a0:22bb:1d3c with SMTP id 6a1803df08f44-8a7025b40bcmr26368956d6.3.1775185745794;
        Thu, 02 Apr 2026 20:09:05 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596e03ce5sm43960226d6.35.2026.04.02.20.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 20:09:05 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 0/3] Fix incorrect overlayfs mmap() and mprotect() LSM access controls
Date: Thu,  2 Apr 2026 23:08:32 -0400
Message-ID: <20260403030848.731867-5-paul@paul-moore.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3185-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 4E7FA3909A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Another week, another revision to this patchset.  The v3 revision can be
found at the lore[1] link below.

The revision still takes the same basic approach introduced in v2, with
the most significant change in v4 being the change to make the backing
file LSM blob conditional on CONFIG_SECURITY.  This requires a number of
other changes to ensure that all accesses of the LSM blob go through a
set of accessor functions which can be converted into dummy functions
when !CONFIG_SECURITY.

While the changes between v3 and v4 were fairly straight forward, there
were enough of them that it felt wrong to preserve the ACKs from previous
revisions.  It would be appreciated if those of you who had previously
ACK'd a patch could take a second look and renew your ACK (or comment on
the problem preventing you from ACK'ing).

Thanks all.

[1] https://lore.kernel.org/linux-security-module/20260327220446.353103-4-paul@paul-moore.com/

--
CHANGELOG:
v4:
- added fs prep patch (Amir)
- added CONFIG_SECURITY conditional code (Amir)
v3:
- fix the LSM hook stubs (kernel robot, Ryan Lee)
- fix the lsm_backing_file_cache allocation size (Ryan Lee)
- minor style, simplicity tweaks to the SELinux patch
v2:
- remove the user O_PATH file patch from Amir
- add the backing_file LSM blob and lifecycle hooks
- update the SELinux code to reflect the other changes
v1:
- initial version

--
Amir Goldstein (1):
      fs: prepare for adding LSM blob to backing_file

Paul Moore (2):
      lsm: add backing_file LSM hooks
      selinux: fix overlayfs mmap() and mprotect() access checks

 fs/backing-file.c                 |   18 +-
 fs/erofs/ishare.c                 |   10 +
 fs/file_table.c                   |   43 ++++-
 fs/fuse/passthrough.c             |    2 
 fs/internal.h                     |    3 
 fs/overlayfs/dir.c                |    2 
 fs/overlayfs/file.c               |    2 
 include/linux/backing-file.h      |    4 
 include/linux/fs.h                |   13 +
 include/linux/lsm_audit.h         |    2 
 include/linux/lsm_hook_defs.h     |    5 
 include/linux/lsm_hooks.h         |    1 
 include/linux/security.h          |   22 ++
 security/lsm.h                    |    1 
 security/lsm_init.c               |    9 +
 security/security.c               |  102 +++++++++++
 security/selinux/hooks.c          |  256 +++++++++++++++++++++---------
 security/selinux/include/objsec.h |   11 +
 18 files changed, 419 insertions(+), 87 deletions(-)


