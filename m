Return-Path: <linux-erofs+bounces-3292-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id smvvFo5L3mmwqAkAu9opvQ
	(envelope-from <linux-erofs+bounces-3292-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 16:13:34 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7323FAF00
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 16:13:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fw5pz32Pjz2ydn;
	Wed, 15 Apr 2026 00:13:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776176011;
	cv=none; b=mSn40WogcvVTm9SqrvPvHXmFs5UIiZ4df1YPaSc2jQv8lM8VFapA/FJLm/HMp9o+jOIwTK5ju/jDf7sB0TZ2XajNrNOkay19Usy7/3S6BTUXc/F2G67r50fBBJlgDcpJWHYuf58bDswxjcLY9drY4PW8lTeKdrvgx5Ulh7HUnpI8uFnXt+KcitVv/6+z0p8Chm4z20Np6CxIMii8uj0L61VSVv17/YVW14QDwnrUcGpOumZv2UH4SRxGsQO2SQedzSqBkcY819UVW0mligcrmQybM6GQeratRozAOIxidv467pwMzpkJ/pwcO3yOz75nl5VXBEYA4KlvCYiGWjqsbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776176011; c=relaxed/relaxed;
	bh=J/FC3Gjcy4MB+hOqeb7ixJYLHAimEg/MGIxJLVE7+r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KW62wr8Wg231ifE8wV4NlXfqm663P62HZ032XbrVQPtM8CdeDFUUtvEEJaVZucoRPcglqDOIwkbzsYvNqYp6YybssNcnCDt+cIE18cUKQ5hNfwD0YIJ7qn2m0S/3Ihxj1Hhl5ovDbudvWml9UMHjHfM85W0I11NWcU8w4LU21ZsQ4uoYcRbuh2Ptt6R0JDS0uCaE20eC7I6BQMofbZD2WFx3q+cZCxr0j8wgox9PVOZZPcbBHCLAK/yEnxTE84NFcEWJ4WaD+vy9fkuQGO8S8gyM9/aZaHzEzoHtKSqrJhWxRRGJJaqRIbucf2dfAHBrdbt/JIS1wc+xRjC2HiYYFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DU916Tn9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DU916Tn9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fw5py2x72z2ySS
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 00:13:30 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2a8fba3f769so25249485ad.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 14 Apr 2026 07:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776176008; x=1776780808; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/FC3Gjcy4MB+hOqeb7ixJYLHAimEg/MGIxJLVE7+r8=;
        b=DU916Tn9bgJZqFdxfcRpu5RE4AOURLFuJpLSz20/571PSSVB7Mvv9KwfvweaPQBvXY
         2PVh8Jth/dPFuEISdwIMolmjGiU09kCHFfw/Ng6H72Ih0hy5cAbuzBxY1oQ95vCFB+tf
         YsQTPMXRm7NvL0BisZ9Z8RoWpRMEMOxiz31DdSKZOtyOS/kY8iJwmDxE9DTrC/s5ckwU
         vqGx/Oi62UNjSas/t0JJO7acsQgWQgGMPt5x05Z6sUQV3a/mA+o9MRtJ+7YBhKENle90
         ZAGAYVP6wY6s56+zf895JptJRJxg71oISFYNUGz4Risibm4DMwjCQ8f7RuS0snmLP7jd
         PVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776176008; x=1776780808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J/FC3Gjcy4MB+hOqeb7ixJYLHAimEg/MGIxJLVE7+r8=;
        b=bkV8vtZoXEtNMngqQth+OaV0XCuJhCbk962HSAFDwYHYNNGamBK7S6QCEVg8e+hqFy
         1Ghjvz8AZX36NpDR/z2br6gcFxPZWq7BHjKyKpHnfF8InjIQcM2QJGkCwfDjjaAVSUat
         mbirr5WXGoiEtju1bIijqYyZtntvRJQAx7qYurHaRUzxvcdLMS1VhoZmdDQEyQhTiEOK
         5YpvlyADnReVbufdWg9n2w1l/mDhItPckfZIu4bZxYmB8sVrDzLC1tOZR6l5U8PBJucN
         dKwJNV3tMPW0tDTNhG7aKt2fVKTFL6NR7r9CF2qZyp/7prQpXRO+s80YhA7g3f9aaLkD
         4IlQ==
X-Gm-Message-State: AOJu0YyR9gBoQNNt40PdIw5tqbK5HHbFwSFxc2SypXVBmwm1/d6ef4kI
	cSAfJmF4VK8FzoCCnLl0GL/90rT6xe0R6CPZ3SE7yJGbWRwWAOgluWny
X-Gm-Gg: AeBDiet6ErbVcyqliqwqRnIaBEnPa+4rAxpRT56DGINTetCUbyAwryEXwy4iO3qTzIX
	/D5YqRGoJSvbZDq5UhMvY9s6ES3crmRpCvd1RhjQM7tcoq+IOyPU1ne/CECvVF0BcuBpn+9WR0m
	qIjhSXyoV2ZmyLbVrNK/t5fGyHME2/xrwv9FQO9fAtkPX7cKGk+d29LXOH/oa9j29Og/7FIRkhd
	8fMeSq41FeAgqVygw+iCd4Q76Ou1W7oE+c0CvLj1VqcQRibRPk5eQaQYFEXKdirbPnQGLm/98qj
	rVGE5gbmoADT3wxiBFpnEjoRmh13t/sFe3khFXv4fzHw/CWz5+t01KmYr/7fL1sPg8X9aK01hJe
	dVkvuOohl3thPxdolxqyuG1zA5agjqAecpBsEE1rtGjyK2zuVcO7KHtfG3c65vRW70FFSs8yzp3
	2TIlYFLgW1WbOO74gT87ClI6Isnt7ASrxWMzNe2fh63TfN3+c=
X-Received: by 2002:a17:902:b698:b0:2ab:230d:2d96 with SMTP id d9443c01a7336-2b2d5976d64mr126946335ad.11.1776176008323;
        Tue, 14 Apr 2026 07:13:28 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b3a73747b8sm81197315ad.47.2026.04.14.07.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 07:13:27 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH 2/2] erofs-utils: tar: add missing NULL checks for GNU long name/link
Date: Tue, 14 Apr 2026 22:13:13 +0800
Message-ID: <20260414141313.46575-3-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414141313.46575-1-zhanxusheng@xiaomi.com>
References: <20260414141313.46575-1-zhanxusheng@xiaomi.com>
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3292-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eh.link:url]
X-Rspamd-Queue-Id: 7F7323FAF00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the GNU long name ('L') and long link ('K') handling, malloc()
return values are not checked.  If st.st_size is excessively large
from a crafted tar header, malloc() fails and returns NULL, then
erofs_iostream_bread() writes to a NULL pointer causing a crash.

Also add the missing PATH_MAX bound check for 'L' entries, which
the 'K' path already had.

Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 lib/tar.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index 3d92f48..24d8314 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -886,7 +886,8 @@ out_eot:
 	case 'L':
 		free(eh.path);
 		eh.path = malloc(st.st_size + 1);
-		if (st.st_size != erofs_iostream_bread(&tar->ios, eh.path,
+		if (!eh.path || st.st_size > PATH_MAX ||
+		    st.st_size != erofs_iostream_bread(&tar->ios, eh.path,
 						       st.st_size))
 			goto invalid_tar;
 		eh.path[st.st_size] = '\0';
@@ -894,8 +895,9 @@ out_eot:
 	case 'K':
 		free(eh.link);
 		eh.link = malloc(st.st_size + 1);
-		if (st.st_size > PATH_MAX || st.st_size !=
-		    erofs_iostream_bread(&tar->ios, eh.link, st.st_size))
+		if (!eh.link || st.st_size > PATH_MAX ||
+		    st.st_size != erofs_iostream_bread(&tar->ios, eh.link,
+						       st.st_size))
 			goto invalid_tar;
 		eh.link[st.st_size] = '\0';
 		goto restart;
-- 
2.43.0


