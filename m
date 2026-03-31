Return-Path: <linux-erofs+bounces-3138-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEKCC4lVy2moGQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3138-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 07:03:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 35881363F9D
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 07:03:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flGGC2kvKz2ybQ;
	Tue, 31 Mar 2026 16:02:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774933379;
	cv=none; b=Ycq/+cNy9DpjLUNrHQ8KH2Y4IWj3DMwhWV8M9U81XN5bCoTjsdgrs1Sj6pwR/ynwr8RGplgmL6diRDuCmZ2/d31cDt22WiJ/SlVdtVQn2fzMhWm6n1cyV5JyzYqRLI2eq22QvmaAHYdIUOVodnjju9viwND2k2f9XYD1x8pg7AvKSvHOj9+BhHK1PxLPnU7pXYMl5Mf+oRtV+CIGzn3aI2hxNoTlQeMZ3x7vjJwvwOIrLNr7wC3+4ZJOdvzO8u70G0zJKxWcaWOMrSWn9SSkujzJ1GaOxgskheR3/FrHyl0od4Q7ZHjIdmUv40mG88jqoN1hPL1j0U+WUv5yeiXNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774933379; c=relaxed/relaxed;
	bh=zy4AmIm0yN4RililkSbv6Ow12X9TuxGtqsseDxGhsIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIPGH7Q9EFUPJF8dMq2rZsftphd3l1WFoaeFdeR7qIYRgIkRFIFYFqLXzLIuac7gvaDDHcSdZq4Ttk5GlaMEJj90FIolRRDfLSdafe61No2D9C+G89K/7OjGxF7AH71pMXkSJk6ddU9Xj0IDJUipmJQmlxtkawu6G5UP56N/NixK29DzcSPnABOt99SzcLXM2M6VSvZcXiBEzaomSXcSQEJiWWRNcvAHIHewUQdoI0MA4b6WnolUFAfznP8Tvq8LyNEoR1cNKxR+E2BZNOjUg0QFYj55TuX4vmIK/64kQikaq49E4zMu0Lzd0jkXzM96yT2Ez6ipgfdrZ42LOdsdvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NM+f0cl5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NM+f0cl5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flGG95LxBz2xSb
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 16:02:57 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2b258576d8cso9300625ad.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 22:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774933374; x=1775538174; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zy4AmIm0yN4RililkSbv6Ow12X9TuxGtqsseDxGhsIo=;
        b=NM+f0cl5wZKdvab3JFy7L6TrzyDIl4X4OpRXHKEytsnX/ilGNw9S7BJQ1ktniwVXX+
         ivJv+BRvtBKsMvfCaBdelVf9o10d9BplcGIaMrXQo/87R2wrETArhHfpakNGvzK8yta3
         NLqwGspQQeQQ653KC/0ZEauz1hTZzbKBJloAGIccLmiGY+opRzXUqwDBlhrXfyWm+vdx
         jnVmuZjHsdyyZMmvkJjdkWRFzSEnKpyKSW9td2xAV43hVDMe8CItrL0gWY0UTRB6IMpv
         I5tTpSZ4syasB3sqZMMqQK5hG6o95Bl1nz0cjDXL40257YBiu0aYZxbtKdNQllptEHK9
         XCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774933374; x=1775538174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zy4AmIm0yN4RililkSbv6Ow12X9TuxGtqsseDxGhsIo=;
        b=P3dV9puNk7NDwTSSIxYusu+IjePbZacmeWmL7kq1IbZKm6s0NVa4e/dou8flh3qTB8
         HuVz1+wSfY9KDPXfijfdrHjkXiSs557eijhczwhYzx+u0XQvE44luoxq/mQ6rrW9DApO
         49zFkgPb5uC9DPVkFGtTNRkXIh/NBJKg7q9YBj36Yl8Fz3YceNjHuOAGjhuiJpJ5+a9G
         T5imGW9yGb8Y710bhsoggXNIR0ss5KGR1iy34hN37qNApgaMpta1YMKdwzR1pyEAj1Vm
         ac/4gjYgj3v9EUhu6UpFot0ep515A5fIPWWAteixRH4I356Vpd44jOd3jlVzrK8CI+Cw
         7osw==
X-Forwarded-Encrypted: i=1; AJvYcCVLirKeiAA1dceCtIztuzu8HLqSDcTLA4xoz7pq9aEGwifTx2U4SlUdnfchHaJEJWaT5uAuv/zNIOydXQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy2luLoJFKArNelKwzbb6a+UVuqMgDSsc6xtnb2fOom5A1/VSKv
	m2hIAQin8qchQA+KXV2t+WV2LOcHN5cL6XF+PhmpJdIw0scXNH9309Y8
X-Gm-Gg: ATEYQzxjgr+/Hct/h+nvsrujS88eVCVOyoJM7CL4/BKEQeMUMoHyhKYEffRDRkqc9qQ
	9nBmhGFivi9B/AJzsHnWO989GXyVMslN5+GOHH8dlDni6l4QM+EzAE+Ux/jf41zD5YEN0MCIHDc
	nBoqssobY3Cpg4aIiyLFDVhDVZy/X1Opo/zubW/mJATSv08tfBjqgF68Ek6AD/S24ALCOp+hYkk
	U2K9f6MmwaIYf1O3lF9zwHJ/puBniOhC68RtwWfZ18u0NsHSxdCJJ+0Nkw1POkQ2JWmAcxBd/+U
	8g1E3MCObnASoZW08DcHTqOQKkjudE7rXqGklxyLQPnT0azly2d1BV52Xm9Ci5LW1IUU+WaTJXD
	LipnS48M/4+qWRN5n7xb3B1KHiCxCaUAMWC/8ylofUrJVmhrKnPPjveBc51QBze2Jtnyql3zB//
	jNe6BttQwuipM7Z96ArncVTMyZbnUTrFRZP3zkMboWs+sMk3Y=
X-Received: by 2002:a17:903:8c5:b0:2ae:61db:797b with SMTP id d9443c01a7336-2b0cda06d17mr162807615ad.0.1774933374551;
        Mon, 30 Mar 2026 22:02:54 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24b02a11esm87585575ad.65.2026.03.30.22.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 22:02:54 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <xiang@kernel.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH] [PATCH v3] erofs: ensure all folios are managed in erofs_try_to_free_all_cached_folios()
Date: Tue, 31 Mar 2026 13:02:49 +0800
Message-ID: <20260331050249.23662-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1828ed19-e9d0-4908-926a-0e0a9c3d04af@linux.alibaba.com>
References: <1828ed19-e9d0-4908-926a-0e0a9c3d04af@linux.alibaba.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3138-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email,xiaomi.com:email,xiaomi.com:mid]
X-Rspamd-Queue-Id: 35881363F9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

folio_trylock() in erofs_try_to_free_all_cached_folios() may
successfully acquire the folio lock, but the subsequent check
for erofs_folio_is_managed() can skip unlocking when the folio
is not managed by EROFS.

As Gao Xiang pointed out, this condition should not happen in
practice because compressed_bvecs[] only holds valid cached folios
at this point — any non-managed folio would have already been
detached by z_erofs_cache_release_folio() under folio lock.

Fix this by adding DBG_BUGON() to catch unexpected folios
and ensure folio_unlock() is always called.

Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/erofs/zdata.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index fe8121df9ef2..b566996a0d1a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -605,8 +605,7 @@ static int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
 			if (!folio_trylock(folio))
 				return -EBUSY;
 
-			if (!erofs_folio_is_managed(sbi, folio))
-				continue;
+			DBG_BUGON(!erofs_folio_is_managed(sbi, folio));
 			pcl->compressed_bvecs[i].page = NULL;
 			folio_detach_private(folio);
 			folio_unlock(folio);
-- 
2.43.0


