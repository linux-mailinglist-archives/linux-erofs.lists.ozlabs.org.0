Return-Path: <linux-erofs+bounces-2940-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHt0FL3AwGmfKgQAu9opvQ
	(envelope-from <linux-erofs+bounces-2940-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 05:25:33 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E642EC6EE
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 05:25:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffKpc0D1Zz2ySc;
	Mon, 23 Mar 2026 15:25:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774239927;
	cv=none; b=J2X1SM8F3s+zpUwgnihHH4RJE3ONsovJs/7NIU+ByK+uLPl3GcjdYDN8KU1zPDH47JgeFqBMd5iZdcgMTeCTrg0DTustdyF8Xo0UxubzXHSU6H0l/mHe436jrdBu6NAfLAH11LUaURQBa/2nHApOIKhyE7ExF6VEoAwchGkS00guCIkoRLRDVA7pfFgzd+EoeBIb/Gp3pQZ2LQyiiLAdJ8pnFmFiHdmwjkb0/f5K4RktX8+LG6MXNr4WZd3jr6ER0Ok/hYlYUiGVbHpnvH2lUvxyTga42bkCcmEHaTN7rO3kZzWYf8z05R9SiB81vVG7vO7UrqA+vqDpkKcZyhXucw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774239927; c=relaxed/relaxed;
	bh=dHNU+T5mQ52dsDV+e3ezWpkvnj+dhj3Dc5R6m19Ae3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VO5QJLhNhfbaZwgCpgm4gO+nCvsr6XE8R3v+iDRNeACUvLTRhYAz6z6R2h3EFvSFm7TPSzmxGB4HIvJdgl7wJGDukg92o1xswsuJuH/s5QPQUeQ67zwkRs27X6iP7HhcaX92UoHD0uh8IqNyn28NFi/I4BIk8hP2MeynDkHhlwNfJflK5JsPDx4chE9zulFo38ZMnP0hR6w3OQJ/m6Zd9ROELCy3ZBmT/6wpN9hvZwD4cnBUbcdCpd+nRyVsMpwZs5Gzq/8qv4wg5WXrKPbTLiCRo5tomewzlczaQ3beOwuftKcDrF6+sNX2H48GWrmJHtcRzyg6R/GgTxiXYeAX2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ZSzbFSXB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72a; helo=mail-qk1-x72a.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ZSzbFSXB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::72a; helo=mail-qk1-x72a.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffKpZ1js0z2xly
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Mar 2026 15:25:25 +1100 (AEDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-8cfc5941028so362430385a.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 21:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774239922; x=1774844722; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHNU+T5mQ52dsDV+e3ezWpkvnj+dhj3Dc5R6m19Ae3g=;
        b=ZSzbFSXBqSUhq/YbUqJpkqLNfPku/PXv5ZBgGmfRdLQVjNOaSWc5RV4+qEo0SRO7zQ
         IU70D5RHgD+/sZVhemUsiBSiMyLGfBlQpPSCrPobfraD2F0aXnaI7C4pEX3c6EX/7B6j
         vFOWm3CPj+whpqbkvdHjQkR9SxLC+luVdDGAPPcON98xsfPd0wyeFtBXkGUCDvsYlwIu
         VsfFBojpjJgpXWcKiH1bTMDdqeaaMOQs1lL1bob76wgsY1FrHdYAyTPceK4AQ5fT/gFW
         U1inC+J2QF+BxhJC76mcjZWDDhEsc+lnvu8LfaWwR2nJB3P8p4asrYCVDzL5c1DPmByk
         wkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774239922; x=1774844722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHNU+T5mQ52dsDV+e3ezWpkvnj+dhj3Dc5R6m19Ae3g=;
        b=j+wTKL6Q3agWkKo9VN09Inx7V4QyqmQILbs24YlTcfXL60CXlW/qCcc91ZHpwztOsQ
         mxJxDvC04h8Oj5UmIS4YFl9CIMnpI4huFcNl0uyPOB2UOYFkOH0Cx5vNBSebh+Vylu3/
         WvWthGRZukKZ4yvb/+xCye6lVsXJbp3mEoyffTzp28qjTPkmG3jClJCC1Dp6oKKDPVtN
         eP65byguAvk55izm+J/HqpDP9z1MM5wvkY4ew/U9/jZxHqcNiOLA6tUfdQ1XQlPFQAHe
         ptbiiGb5Y75yhQJktpSo493P2FnkGTRWkbZ/f2eCJ08vgtMpH/4PEiFpCjG7ktSINr2v
         tVJA==
X-Forwarded-Encrypted: i=1; AJvYcCWXuC8xCidyQXntiO7oO9wNh/Q4mFq8I1CWcl/N4sMeQNPVgbe3E8OLygpnvksTgQl7OwA9dOmhVQkorQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz+7PBbHXRNvIh9l76FwQNhmXFHUGK51/PfWkclcm9VtDwk5y3o
	7XYM1Zg8gqiEszkWvbAVK0pFdTyrEJZA7cZ3s6D0IqP0W1rjNMeXVB20cQTGDGWgqg==
X-Gm-Gg: ATEYQzy5tTbOxuTSfYLbrlKkxjrv7oPEli0Kl44/aTWLcwQgXZfyttbaWZQrlK0ThKT
	E6dSM1xYfVSFB38GcMTkPrpkiP2wJYC4FERqbCn3BEeFOuCFRQMO4MgsXCYhtV0cND6vfC+ztI5
	9BfI3iHOCGK65upnL+jIW1+lsPRKxt+oO041SKVmPQXgaU27qquG/gSvxIHK4ulgDozeofDQ3gT
	mWC88DWrT3C/YQXRBdAcrN4o8dn8Aa61/mj5LGZY4fIocgYTJNW7tPmqylXzuwuOruxm34jM1w3
	WpRSspq4kaS4wKTpbkInV3+NFzvKDgssb5tRvu+JbspVUvAlZi3rV+J+YCms3eh8N6JJzwa9QBG
	RPDxiVER3UpzLGw58bIuhW7IiPnafFtRQDMJcWgGJIPNCIFMgqHcYwvBTSuu94kPpLe5rBndQg5
	q5gPLa7iSPFlJ39prC+LQDPNJ47F0buyb0/xIyIa9ZTXdGETnwxLWWV5Qxo/yPi618HzsZ
X-Received: by 2002:a05:620a:3193:b0:8cd:94a5:2f22 with SMTP id af79cd13be357-8cfc7e6d7eamr1552756685a.20.1774239922032;
        Sun, 22 Mar 2026 21:25:22 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8f5fa29sm677110285a.10.2026.03.22.21.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 21:25:21 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>
Subject: [RFC PATCH v2 0/2] Fix incorrect overlayfs mmap() and mprotect() LSM access controls
Date: Mon, 23 Mar 2026 00:24:17 -0400
Message-ID: <20260323042510.3331778-4-paul@paul-moore.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2940-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 84E642EC6EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a follow-up revision to the patchset[1] posted a week ago.  This
second version has changed significantly in terms of approach and
implementation, as it has become clear that the overlayfs/VFS devs are
unable to make the user O_PATH file approach work.  Unfortunately, this
pushes a lot of the complexity down into the LSM, as opposed to the
backing file code, and will likely result in code and state duplication
across the different LSMs, but at this point in time it doesn't appear
we have any other options.

I'm marking this patchset as a RFC since I've only done basic testing
on this patchset, and I still haven't satisfied myself that the code
covers all of the different cases.  Additional inspection and testing
is required, however, please feel free to take a look and comment on
anything that looks odd.  As always, additional testing is welcome and
encouraged.

[1] https://lore.kernel.org/linux-security-module/20260316213606.374109-5-paul@paul-moore.com/

--
CHANGELOG:
v2:
- remove the user O_PATH file patch from Amir
- add the backing_file LSM blob and lifecycle hooks
- update the SELinux code to reflect the other changes
v1:
- initial version

--
Paul Moore (2):
      lsm: add backing_file LSM hooks
      selinux: fix overlayfs mmap() and mprotect() access checks

 fs/backing-file.c                 |   18 +-
 fs/erofs/ishare.c                 |   10 +
 fs/file_table.c                   |   21 ++
 fs/fuse/passthrough.c             |    2 
 fs/internal.h                     |    3 
 fs/overlayfs/dir.c                |    2 
 fs/overlayfs/file.c               |    2 
 include/linux/backing-file.h      |    4 
 include/linux/fs.h                |    1 
 include/linux/lsm_audit.h         |    2 
 include/linux/lsm_hook_defs.h     |    5 
 include/linux/lsm_hooks.h         |    1 
 include/linux/security.h          |   22 ++
 security/lsm.h                    |    1 
 security/lsm_init.c               |    9 +
 security/security.c               |  100 +++++++++++
 security/selinux/hooks.c          |  252 +++++++++++++++++++++---------
 security/selinux/include/objsec.h |   17 ++
 18 files changed, 387 insertions(+), 85 deletions(-)


