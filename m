Return-Path: <linux-erofs+bounces-3294-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG2uH1VT3mlIqQkAu9opvQ
	(envelope-from <linux-erofs+bounces-3294-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 16:46:45 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2012B3FB76C
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 16:46:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fw6YF0GGYz2yVL;
	Wed, 15 Apr 2026 00:46:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776178000;
	cv=none; b=KNrV4LDgXS5TNw7VEcICrUGRbB9UaOzk36MJhniDTglBg4pxOv8208oEphSqwdoyFCvp+idlgXU4g/VET4Bmz9OzpULkJ4eS30a6GZ0LLdo/jVNh9VNFnLRYKiAxb/AmITXc2tKDMdlRq5FCHw9K5cyVTLaBhbBNwngwO4iDoS/OpwGLBcBtOxKn+uWdZIn21D4y9CWcTzIfMsZlZ9WHiGjZYIiCPrBRJRk/Hp5NctDR45qm+YHT1TVCZhHk/Va+cSDXKmaMQZax4gfZ4kFSWeWQooOjpt8kWLBt+CRHTKkTQ/YTMluMLvszb/8iQx+ylexQkPkHS5+4TqgtXr0qHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776178000; c=relaxed/relaxed;
	bh=Qn+attenAv4h4gLzPzMkd1HSx4vnLXMwC3Fo6bP+YXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwOyqri9VUwiv1HaEE2USuOxJqolTRN/FpZWxTW65/vi2L2kVLtzT28l7CnyVKqYBy1sAceBS7NTWIClDRJnIz7G1aa9r42ZXafQMZpYw3Vm/iug0XPyvsE+LMiQNII38Ih3BA5Gt4W0nysZ8h5fWR9GkzOcpQmXO75UEnEGFnhOBMqAVnj2LLYYmz6+FDh9cF/Win0BF7IkfEbmoToOUCrdeA5qU9U2vu+MLXtqRJ3PalWivnM9F6TdqbudPyjftpKv8mBeVql8eykq/6omW1YMcahhzKM7QXUQIpyM+0Kf2BX6D9OGn1BjwJvCgr4KTAuszsDQvw2Ris5NX23AVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CWl84O4v; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CWl84O4v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fw6YC6crnz2xMY
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 00:46:39 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-82f1bfc9b8fso1586549b3a.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 14 Apr 2026 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776177996; x=1776782796; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qn+attenAv4h4gLzPzMkd1HSx4vnLXMwC3Fo6bP+YXo=;
        b=CWl84O4v1G80ZOZVKGW6XEoNZHSCzuk39QC3XwmTBunpWBecfFgFWLTyQN0At1UkOJ
         CTarc880fqnK5AynTxPwDoxiDmcXRa4UoU4uuJgqvRMWf0MTMHPkPmYZmISyXak0vvF1
         wxqQpHJ3AJTuX5aIBbJTEjnBSPngV0f14OQ3qote47OxeGSgQfIWY66O68cETCS5pyPL
         nM+LL83ZVJB56CdOh0QPu2BxeFwCf4zPdlYepXgmEI5e9MLQ+GVQSmlX33wuYsgJsMB0
         5zr2JVnrdgpdplIvUzeI7IbdYk16Pr6kiXevKfNCp5+PHCwtD0A5WoKVbO3GSAzun53b
         vTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776177996; x=1776782796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qn+attenAv4h4gLzPzMkd1HSx4vnLXMwC3Fo6bP+YXo=;
        b=dRQZCD+vZ3CNu7sVpRAUSyIT3FPW1qumF9GhA3BfkhiEMyvZX5KyTPg/Vz0wYHqCCt
         mp29AGDFy1tRSQ0ccAemmT38kpLyJlWDjoaByrZ8hykC0fElLdATDUw0QmU4RutPuI2d
         nyX6LXXACYxd5vYzaU41lH/UQmNnTgo+UnLQrbw/GuxOihvAA9A0c+kqsz6xsmq3IFZ5
         SNHwGAxF7XF04/oX6LhbPk4TlB2BRJ5UAu1TKLNtZ7hAGbvIEq5rvKR/SIkMEMUHAkyv
         wjIN6G5ShAa5/PReQjbcf6jdKvgFql6pVqAObYHHA4iEu2KQOIkO3d9Lv0uxmuK8DM3n
         G6xw==
X-Gm-Message-State: AOJu0YwBkJOq4eBfWOwps/vuyRwqzIvx2lMm/yy5X26zAxOe6oWUx2SR
	txqOaqKwt6TmxkssIzpUD8HvxdBx5uuKVEVXFAB7X7Shl0Ppm3qMb/Xi
X-Gm-Gg: AeBDievYUbaccAPQJQ4sSjRW/fGBYKyPJfGTCo55zb2TTDmXPWA08K8Ww7ZncorWJIo
	GWlzChkh5LGMCJ15sW8nXCegZZAlp3xycDyOsW/wOwSJscZVSz7b2TDntfuNk50Z5PKQhfH4zH2
	7pNVaEQD1+azY1LXCn6E/LFY+FCGOoXD+Hjzocrj/HO8iicbwWjI7fINZgi0RVEnWulqqMBjPHW
	IMVTHne7/dfIGV2cb+zGuJ02ShpKSgZnXDHe3pL3jTZ5C7ZmvtKRL+GurudBPDPpw4QvNPGWoHT
	NXLr5X9dLplwaypj/pNtz7s8YjIVAn10myint94eMZ1+6ESjpybL04zRroDH3kJy8KNN/R0p1WP
	hjUxtgmwSnpUKmIjBtGz6QZXAyjuk6KeO9y5m+F63k5I03QRF4udKpxKU1YXGFZeO3LW2clBXEQ
	IcPtHI6jeBrT2W80EXE/XfN8X+w0/KkzVJ/jI4xw72QFfmR5c=
X-Received: by 2002:a05:6a00:1bcd:b0:82c:e60c:f376 with SMTP id d2e1a72fcca58-82f0c3630b6mr17592346b3a.47.1776177996085;
        Tue, 14 Apr 2026 07:46:36 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee3fsm15488124b3a.12.2026.04.14.07.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 07:46:35 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH erofs-utils 0/2] tar: fix parsing issues for pax and GNU extensions
Date: Tue, 14 Apr 2026 22:46:32 +0800
Message-ID: <20260414144632.46859-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <fb13fd1a-e929-4c7b-a8cd-ca0cc80d0ab0@linux.alibaba.com>
References: <fb13fd1a-e929-4c7b-a8cd-ca0cc80d0ab0@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3294-lists,linux-erofs=lfdr.de];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 2012B3FB76C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Gao,

Thanks!

The issue was identified during manual code review. I occasionally
use LLMs to help polish commit messages or double-check wording.

Thanks for adding my Signed-off-by.

Best regards,
Zhan Xusheng

