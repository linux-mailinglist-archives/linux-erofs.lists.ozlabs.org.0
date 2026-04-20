Return-Path: <linux-erofs+bounces-3330-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBMJCn2U5WnrlgEAu9opvQ
	(envelope-from <linux-erofs+bounces-3330-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 04:50:37 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB792426696
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 04:50:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzVN90SKDz2ySf;
	Mon, 20 Apr 2026 12:50:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776653432;
	cv=none; b=V8j+HrAgVCu2VLh+8zuvgx4yWV/8NOJC10VwRGAAU35qiJNpqEfcDgBLiMU1+0YkVHcbsWE1Ox8KHuT54W+hQ7XKVFv0MQZt5zLkFNjKVtcaBZkRUyqsOOij8b1AKDrfOaBuvzp7GY62MtrcBFF6JwrxYAej+9Pj/NCVTmCjlVzGOIodkq6JsQ1PbOQRmTHc7REMsI89XEkXsDkPRKqj4tvm0AqEXpQ3TzBNYsf+yhi1Eo+VQ1z9O3Yz/3fNDC49rdYhbBsJPrAbDeil/0g3SuFnuSvS52XLNk848pSt8IPMGmYLLB/k55hycUbvblcv/kXU4w5aeQECS/llYZ5d+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776653432; c=relaxed/relaxed;
	bh=hRFM6I5ZNdaqva0M7WqVFOR+Z1EMtDmZaKvNk//HmbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gv72IV8uixH20w0XTkiLHpvRsmCa3mmV3cuDGOMYr68cpi7Q7YWRUVnfq9paEnnY1xGi3Q39XNF/genwtrYH8BzC7IW0wE1yn/5YVjJbM4K3R9hGoyTj5Ba841bZbkA/S2iLcwl5kVqrK5oz8n4vlLZkFLIdTQeIM3Wbai/2kSB8nLlbHCNUfZ0Wh7L77Ez598nemgj2L4VLjX9XdVIDiJetDb8EACEWUys2gZ4WZXAVCS21O4EiI7K+i4D1KOg7I/PvIQqUVNL3nzqOYipUQ7QVwusIsb2WYcnAFjFjXJFHkXs6lf+CTnRBDtYaPs5SmCIW3N30z08nq7s4us8NNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mGhahbUg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mGhahbUg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzVN74WBWz2yL8
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Apr 2026 12:50:31 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso2392918a91.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 19 Apr 2026 19:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776653429; x=1777258229; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRFM6I5ZNdaqva0M7WqVFOR+Z1EMtDmZaKvNk//HmbQ=;
        b=mGhahbUgeRc+gOUUSZt7tYsg2q8OclVW5JGTqFcMYtnmNUIxa4IxDpMmWBOHM2Ny1L
         fkO1BoL5lmatracdDcG6Zi3b2oBg6t4Y+TerwONuMPvp+QbzmWRghSsyIglMwjgp3YzA
         fccNjf8YENSgatsWy5z8RG2hhhItYy1SzNU204kZOO+lSWbWMeDHS8OKRuPM46SCQP+M
         mSxIdHBR0KUntzjnRRpge4TCNadqKj8ux+A2OZxmUBh4INWgdsPRhDcTlqZOU0a6g/CK
         ItT+UFGDDvKApOu3jWLu34uGhBEjMi9Kl5Dkb61lM4qHcMW6UhHPjFCsBvKfCKC8RMi+
         sWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776653429; x=1777258229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRFM6I5ZNdaqva0M7WqVFOR+Z1EMtDmZaKvNk//HmbQ=;
        b=jbWY097ft90wqZ4Piw9J0ZupVW42LtkmEVroY7BS/HoO/hL3OWjB27ST9CJa3tYTtX
         imD89vYHsx1/M6B6UCy4VhXi8MNs+r75KtzXMQhmgOVY2FXYrc4S/38uh/8ZKqKF30C8
         qUh5ey59dIl31cV8pEjTaVaVt564PCYuiyJDxNvj1+NhmKY2IIFWtUUmf3Yo2BHIeDbp
         zZ87VZFsrOvj/OULweFYmJy1cPEyOod9oAfuFuphZHyZmSzShXYe3hqQ0VFyZ737ssuv
         zZEXvSCa3SNpzD0I6oCd4oPTXjxP37nqVQgoD3WCgtLw4ZLlUSo2n1Q42U7iSzQ7Jj+Z
         Z0UA==
X-Gm-Message-State: AOJu0Yw3fqytzmjaT13QPLO8Jgx4n2d1fpiukHMNP/igg4wVVYgBuTNO
	jv/Mg2LYNUibzFpXyKnvJA106t+Vg0Wk0a27/rzxji8zALHhVJf1q7So
X-Gm-Gg: AeBDievhrU6hWdjxsdL0RSV3NLXoS/unHHvf2u8cJl0q84ae/wQRnRRBRe5AgW7sdR+
	dcJAwwvzWG1tp1ki9jOPczY0g9nYYEkDQN5z8/Q8G5xRGTfS/ct8W7vgIzvGyEyTIHtFzm6F4VR
	JIGYuVi1zaUIIL5msTFw8+9jLdxG959XrLSb+wBq1VdDpYWY6Rs9LZnNrWZbWQ/JQW3YEO32qPk
	d39/z+OBezxA0XtlMiEPWGgF4HRCqe1R61lctAM3altKKUOFiHnsUWeVCjAnKfqdXQzOF8IaMyt
	OvwccvGzaQQw9pqw+Gz+mKycz3cPnAjoIIcTuS784ZnMMDWTtORap93czZ6yjq5LWkrSzIv/ygQ
	p4NCC+TdxEUmsos3va12gnJ7k2SsDGogycPMaBzYD7ZCpM8ggLrIETJdlnh/3z5KuobCk62IEcj
	lkB75Tluzzp/cg+FvkbF0jP3hVnxQNxCtkeUG4Tm3g+JvDz8X2xjANbRpXHslOGSTWF8M=
X-Received: by 2002:a17:90b:2686:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-36140499690mr11859975a91.23.1776653429084;
        Sun, 19 Apr 2026 19:50:29 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410b998fsm8854374a91.13.2026.04.19.19.50.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Apr 2026 19:50:28 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	nithurshen.dev@gmail.com,
	xiang@kernel.org
Subject: [PATCH 2/2] erofs-utils: libzstd: fix undefined behavior shift in setdictsize
Date: Mon, 20 Apr 2026 08:20:23 +0530
Message-ID: <20260420025023.11802-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <00f14a87-6914-4e4a-96f1-6d0f911edc4d@linux.alibaba.com>
References: <00f14a87-6914-4e4a-96f1-6d0f911edc4d@linux.alibaba.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3330-lists,linux-erofs=lfdr.de];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:nithurshen.dev@gmail.com,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: DB792426696
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Xiang,

I do agree that `pclustersize_max` is always greater than 0 and
`ondisk_extradevs` is at max 65535.

My intent was to look at these functions as independent blocks.
Even though the current upstream callers provide safe inputs, I
wanted to make them robust against any undefined behavior in case
they are reused in the future.

Thanks,
Nithurshen

Regards,
Nithurshen

