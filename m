Return-Path: <linux-erofs+bounces-2889-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIA1KC1+vWnH+QIAu9opvQ
	(envelope-from <linux-erofs+bounces-2889-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 18:04:45 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA5F2DE385
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 18:04:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcpp12vT6z2ybQ;
	Sat, 21 Mar 2026 04:04:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774026281;
	cv=none; b=EHyX6YfPrzbDo84QiXLP6sdkbzNxZYg7oO6TAqqGoueEaYBUZhH34SwTiVBS3WxnAfAWrwGWDgimZBiYdsQfqNS5ehDN6rl+29vQ92htj8wkW3OuRrh+DFA8Q8iSUxnJ9wSFwdEnKX+raMwgxoEv1ZOFIvMm+UOff58RbiUkxEFvlzzBwj0xPRvRXHWwRsqbGSvoThN8OsiMwCBlhxF0IAQkSGDSKgLoSYnzTSn3oXKR4W8NGVqG2dz5XV/jVRQu5C0QyWf3LizWPGPBVSzRmVVwDF/rLjyk5FQmhHI3WHTlEv10CDvPEyv+aF+cWBywH0eRtk5h0zxOKea/sxYJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774026281; c=relaxed/relaxed;
	bh=qVr3JZALpkfpg9Wbf7k/4Q8kZJCuKpBZLexIsL8t3/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Psa9SDWaY8aHvROLkRWV4k74SEpsgLOzLhEMFJKwd+cknHfOSAbsWnhKVkVIpqFZR9Rw/hU6P1USjgdIonbh6fujRUOqUERTib7rFXRcFssInWBdtt1JUvfbBu68Oy66dmg6Eo87XAJDJHw10/+aRwOa7tI/nJxbl5AAXeoFXQvIkKyKWUh6IQdnV6yHDhCiGcd8XMWBRupvtRspmIO4nY39XYNe3C2X4TKopFscUH+vfALiLQcOmLgntX2Tj9GUDVCnyej86Mm+I4QNyoQyROFQKFjwrPg5BzqAO50YbIBuWrGf4ioh/uMDqEDrTDcntJOg6qfqxDov1xzXfnL+Gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Qf0BRmRb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Qf0BRmRb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcpp03jn8z2xN2
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 04:04:39 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2aaf43014d0so13385605ad.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774026276; x=1774631076; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVr3JZALpkfpg9Wbf7k/4Q8kZJCuKpBZLexIsL8t3/0=;
        b=Qf0BRmRbjxe4gLpnv19mDr62bmlMG6TIbibeqAs3PO4HDhyAxkawR18z1jqbpk4IxL
         uINaHCJB2CGxIQ8sLSBaxx3Dh0ZIC1kdwjBPLwNoNa+cWWbo3CbhbYHT+CZazENmSlfr
         w2gkLSRcylXcGeM7Gt3PooWMrxDcZXNFKbq1D14limKBhaDcjowZ6vgz2NtA6jPu3Jz5
         //0rvow+EVADya1GnydVYdHou2TY5ZtPhJioxMBsaFbqLfgBD5EP80iZsac1iYkbs6Sj
         5b2TE8jzPhP3JYRkIn/8UJYj+szALjtpHoeguYYZoT2l86SDXLL5yIt5mugiJU2tgyOA
         RihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774026276; x=1774631076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qVr3JZALpkfpg9Wbf7k/4Q8kZJCuKpBZLexIsL8t3/0=;
        b=VjyWLHkhAXuRCdypSLh9IflXpxu2C0/5nzyo9DxRMDJneFtZNO06gOyGdOGK6k4X+o
         q77GLHMD6cx9VY9owwAB5qbyLIO0kl26GxXTqXah/B05WKDtsosjk1V7fPYeuOrE+ejy
         40ySXJKtyawNlJGlVHiSYKZcnhfIAxhvrC8C0p9403WzKWPWm7WTj8PqwxBfQFBohSsb
         aMEnjlbeUx9M9g7XOjd5cvu46BacdW5w5j2aPjxkKyQJ69xcu7tloTfdjBvY/lWC2VHJ
         vs9O2+0qHoZU7GfBCcVxpHf3jVJ7ErItEg34KHUgg3dgDamhkzNonRn1ntEgvbHQXnyC
         pwEA==
X-Gm-Message-State: AOJu0YxiI2IYumRLh04Wd+vlBvoOCylawGM8ZhJL11t6UQPJOWr+XWWT
	HA6RKbDOY0JNeKGQT2MeUGQTZnjfNEzbNPiYLhZmhrItU9zNBB/LqjzZYSC7Ypmw
X-Gm-Gg: ATEYQzyuQk1ZvXIHGaQnR/uJ7Fq2O4Uq9L5ZAb2pErVArFmu0L2P8gYv/7M4lw62rNR
	Nx1aEyFPNlep8nG5SMqGB+rL1dvD4P5RX0h0KrNEDUWXLQfISJ9G+vQHxI0p25RdJ9rt8+Utm5l
	ssLDeZW+bRfl3cKLH9gdaJxDFwVCycnDFTuwY11lP43KxAXfBffh3sto817R9Lh2zDpIhGhh5Az
	TkmWJnMQ6RZ3iznXnKjBFsh/e7XTQ6W8amIyNz4CBHVffoermbZFcu4rHbAxdlwzSlEWCPzFBWU
	+oAEJTeOHfflEGGSWG7nr2V8ACaT9ojL0UjcSApLBPqB6G0sRcSvwN3U0hpQ4upfNw2FOorJ+Dm
	11LEpHISVHaBw2L2FwzqJaPpbLlfSsTfylbAKFPs0k0S5nev5EVWG8G1KJGNNAMgdH7WFWjt4zl
	54a7vNmL3DaR9D6nCj1uPtotnAUOo/wD+R3xlzuAE9LdGQ4fmbqEmrGpgE
X-Received: by 2002:a17:903:2984:b0:2b0:6a22:5165 with SMTP id d9443c01a7336-2b0826d7416mr34328225ad.7.1774026276154;
        Fri, 20 Mar 2026 10:04:36 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c744aa0bbdcsm1985258a12.32.2026.03.20.10.04.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Mar 2026 10:04:35 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: newajay.11r@gmail.com
Cc: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: Re: [PATCH] erofs-utils: fix resource leaks and missing returns on error paths
Date: Fri, 20 Mar 2026 22:34:30 +0530
Message-ID: <20260320170430.43337-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320165200.1862-1-newajay.11r@gmail.com>
References: <20260320165200.1862-1-newajay.11r@gmail.com>
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
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2889-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:newajay.11r@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:newajay11r@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 0BA5F2DE385
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ajay,

I will test and verify this patch shortly.
But, can you please send a v2 of this in two sperate patches with a
cover letter, as both of your changes are completely unrelated to each
other.

Thanks and Regards
Nithurshen

