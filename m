Return-Path: <linux-erofs+bounces-2931-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Bh7LQ2vv2lO7gMAu9opvQ
	(envelope-from <linux-erofs+bounces-2931-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 09:57:49 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B362E8AD9
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 09:57:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdqv74mW4z2ySb;
	Sun, 22 Mar 2026 19:57:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774169859;
	cv=none; b=msV07ga0LNjK0Ie4C0d2KNqP9ZBKbv1vnaUQt6wHe5jNrZOdGVTw3l4kq4e9mqN2bvCM/ta+LA0vHr6cS9xCrZtqwaOLlgaECYYiDjzXJQc7NKsXd9hGu13AYg8eguI5b1dr6Ijx2hM+mY0YTlvEwGyQVeLoQIQ+uokRke0ctDoxnyZnS/LL1YQQT+VF1ltXyidc9ZTgYDlr8UFu6dBPh1CMOILYiw0EAlGTpxycZWAwpobNmRkvBs8KzQQP7hwaqiFaA9GsG7XyFwr5J+ui6rVkyj6Y7L4vxPmzgp12nQMwtooVRN7Zy3GMt+HL38h548+T0GX92Il03iZqXcmZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774169859; c=relaxed/relaxed;
	bh=ABtDW72c/A+EGvPAoyOtWgxI9NF3+9J0hlGLLM56ZIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ka+MRK1rUGuvxNDBgiBR1UP+fGiGgvaGwUQsVDPbB7f1lbc7bOcUiwEghtxq0rX5xy6hxGHOMnfHciHnJ0wlNl/t2kFQsjrcZWyObNmUetSzBFE8Y7XJJO8IZ+RTYppiGwd1a9BeBJhhZ0b60KegvSvYnyFDV5Wa8rLjaW//lBZFebIWQVoDY1/2kPnaOgl/q05TWwmxVkNHQEBXHenxyMW1Q/HH4WMCbZd36XpAdolVzunAOf1Itx24b6hS8gs1BiGqvnfla0fK1mCMxaqp010QX3kXwy54B8niKHTDKqFddJ+r+h/Z6jkzkt9F8O9pKiNXAlnKQ2mZYhhR3rPYKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=O+tOQUqO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=O+tOQUqO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdqv63cBRz2xlr
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 19:57:37 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-82c20b9f989so745268b3a.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 01:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774169855; x=1774774655; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABtDW72c/A+EGvPAoyOtWgxI9NF3+9J0hlGLLM56ZIU=;
        b=O+tOQUqO5bkJc0ZnBOSlOz65y2ilngs7YfzccmNt2sKt2jLlu/OjI0gloUm8trdBOb
         tL8EziMVYlp6OPgYiAUMTr6YPo6TQwaeMjCTuBD2mYA1xW13gHUZP9MI7+Bd27K9IVXh
         lQFXtR8s1OhH0cc/XhyKK9GmeqVTTV89DkTgRWCp4DefOTR5S7Thbgybqzy/Qaskmbl9
         CK3+8zDvGeG5739Ppt55WydawMqqRJ0Yh1+bGXJCxDz7YFcrEehGB8aJdpchrT7ZDgFl
         L/vvbEzkyrqAyQqmWbh4y2JujWyx0WTFCHLPPs3HuMumX3Nm26T/RKSIH8oCnoIi+ZKl
         sk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774169855; x=1774774655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ABtDW72c/A+EGvPAoyOtWgxI9NF3+9J0hlGLLM56ZIU=;
        b=WtC4H2EA6Uhl388s8gSWvWBzSNrHIafYZae/llxDc63muCtolXHZSoTsC9ZUHPzhE0
         2o/1JOcZy7DAEybGGyVm8+zrwAoaUDsaHuix4liUX3XsTLnr6QBxlGkf9jnFO5Na7Th2
         6Ph9i0x1nk/wOVlKBEBGZdzNP17BaM102ndLVKUJMNAYZC1PCXBzO2u6FtOXwCeYAgEU
         Gt9uvfan+NPvrUlhoNZ322cJK7YHtK09M6Gsdcpc0TGfeVDaNrPGpQ0unDg0W3kXU6tN
         Z0DBRSLwmOuHM6+usS2FzMiQTp1vOZ8r5lFztCXyQaGZYWsUyGqxQfpw2jlRbd75R0dA
         uEKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6PBDlU8Oj71dbCOHa+aKUpUNiIWqsF0C7vYIh96XYw9AqZm97bddqvNDbfypx5NpH57KJhsUorC8z6g==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwWf7is/wR8Kcd9Nk9cVAiBA1v3hXR8quwbgReeBMPzbQmjYw9Z
	N1NaWb7iDISxGlpXecpQ+SEMo/yNpRYbd3e+BuLMXe+M14hAY2lntY3F
X-Gm-Gg: ATEYQzxsUBa9eGN2bkUkt1ZbAfGtmiBTRFzLWqa4V0Twf967KKRjcn2TxJ/yStZUdf3
	HU8/PKnKb2s6YOndqrkzkGlCVoAOOqdMYa9S/w1lGiky0tzvz2YQpBlHCn53FXekhbgMidLxSUs
	eX353FODr13+T241vYku96ultN73Cufkg/ih7tbjQYZWiI3AlWNmXV6fQ7079iTa9PYGTezDqjQ
	JKPj/CAUgDYcvulr+5HjOMxxCqw2FD55oR4EhDQZ7XOl1N6RcWW8jt6xAmzofMrAo9diQyRTHEK
	CZyeRNidrkl0L+RqP27RbPeHDAfFH1FgBQ8q28i3BJKfG360qpWeRHT4p9x6yv3G3mMqRlMdwrj
	tLfTT0iGRPJ9MssC3yWIzoGQWfRhNGvke0E3GOm6THGRy5YBscGEefinXpUbRnpIK0//T9mZjMI
	xjrxDpw94DRW0h+3fZHM1OkMEMQCUn/AHmhSn4AWmv+NlMCdfr1ELnC5rh
X-Received: by 2002:a05:6a20:394c:b0:398:7cb3:2bf0 with SMTP id adf61e73a8af0-39bceb47d77mr7112067637.36.1774169854958;
        Sun, 22 Mar 2026 01:57:34 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a938aebsm5212455a12.17.2026.03.22.01.57.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Mar 2026 01:57:34 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: nithurshen.dev@gmail.com
Cc: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	singhutkal015@gmail.com,
	xiang@kernel.org
Subject: Re: [PATCH] fsck: add --workers option to configure worker threads
Date: Sun, 22 Mar 2026 14:27:29 +0530
Message-ID: <20260322085729.24511-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260322083620.19933-1-nithurshen.dev@gmail.com>
References: <20260322083620.19933-1-nithurshen.dev@gmail.com>
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
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2931-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:singhutkal015@gmail.com,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[linux.alibaba.com,lists.ozlabs.org,gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C0B362E8AD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As you know, currently decompression process in fsck.erofs is currently
strictly single threaded. In fsck/main.c, erofs_verify_inode_data
still processes blocks synchronously via a standard while loop.
Without wiring this flag to the workqueue engine in lib/workqueue.c,
the option doesn't currently change the tool's behavior.

And as you know "Multi-threaded Decompression Support in fsck.erofs"
is actually an official GSoC 2026 project idea and the project will
likely involve a comprehensive design of the parallelized
architecture, landing just the --workers CLI portion now might be
premature or conflict with the eventual design chosen by the GSoC
contributor.

I'd suggest reaching out to the mentors on the list to see if they
want to hold off on this patch until the GSoC project kicks off.
Also, if you do send a v2, switching to strtol() would be safer to
avoid potential -1 wrap-around issues on 32-bit systems.

Best,
Nithurshen

