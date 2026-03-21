Return-Path: <linux-erofs+bounces-2895-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Vq2pGqEnvmlQHwMAu9opvQ
	(envelope-from <linux-erofs+bounces-2895-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 06:07:45 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EC92E34D5
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 06:07:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd6rB6Jy9z2yYq;
	Sat, 21 Mar 2026 16:07:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774069658;
	cv=none; b=RWOhebWhOZwhb5vzJG2Xsgo8fyYR+gn9Ghe1bevH3TaIbp7LVCQ8qjTjc2B82uC2WiF81sbRHk+1RYgiV2C6iv8aUIdiKy1Jp3wLN4GpRfNCrpouDJo2oYAztorLfRrUGPPtuTUMkGD41jlBo42fRnVwztYuhzhWPtb+ayVR3GDphdkdx3HMPCUGkuID+gVQfX5TYkxaANvtsFl7drIW7FH7Il1qyozuyx1QQeSpRYJnxIrqTk/1bMmorqjTXMrJ1MEN9qZLqf9AITlc/mb4glrf4qL5MMcBtbGm8ssidBQ0bxvXSaeOgB0e5nQi8vVdYDpMtCE7UtuRLpdkYK65ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774069658; c=relaxed/relaxed;
	bh=EgBUBmJQtHd76HLX7HG5UBJswn9iQkwtYC8lanvfbH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLsaICz4N/cli75URB7RJJyoPrRVB+7/HEzyGrfXQUX/1X/c2PNQhkasl71uJurKttMJCGR7is1eoZaznb3ah87GIiE0e4rVMbsMGdkTIaYYGqwQqKx4oeJGFE3EZU+eBn8mJJka7WSYv0k4jyROHuHUNUKAHxQnFOBHHEkX/PEuTduaV7esfB3GdY0P7qPudxvF9ao+VgKlc54K7CuHPFZVc5Xuw3YJ+xJ4oDthIJpvn5HnYrbA3BlX/nNImIMBV4dHUAqWU0/Mxhgklp1yJi41ZbjmPUthWZuwOPYbQjIk8pz16YnQTZ4olW4/Jc7rkBmroGl6evse/wPAoDwxtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UQnbFUs0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UQnbFUs0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd6r946Tfz2xP9
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 16:07:35 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2ad21f437eeso21985675ad.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 22:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774069652; x=1774674452; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgBUBmJQtHd76HLX7HG5UBJswn9iQkwtYC8lanvfbH8=;
        b=UQnbFUs09GBRma4RlRkFQ4AT5zG5P0Jxayu6yKSXVXRz0fPyO5TpoCTuwgGWhxTfBA
         NZVbLEwBX4mVIKwUnrQpkOJu2gAI+ZZeR1dSm1mBXzITLnjFxiqcK+DrJe6ff7W9dMsM
         dNfOPSdNyMMqOUyV4EzpgRJ+75PsTJC66jcMx/TkJKr2036KLrs5RLPsaRximTB2c2H8
         VOhbhLX9HxJ0LpbqquSg5bO3lGQzBn6nPFEePkymiFXJtIUWogXNhcKyT9X+JyB8k90t
         n2WF9/euiX69Hy8WZWj0XqNrOR2HF8tfYixIyM6Ss4DUayOfLcM3pM358USjL0Xw1cXq
         U0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774069652; x=1774674452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EgBUBmJQtHd76HLX7HG5UBJswn9iQkwtYC8lanvfbH8=;
        b=QAZlzJ6vm+L5oVUkgvePk5x8/FboyrXHU71eLu5aQrYV9OMj4Ish4XnVF2aqip+kSJ
         Jx7B292GxPvQQp0aU7d8IJxrMRGNfVzROBcwUoWvEMiBYesPxDC3Z05xpu7L+doYXfEU
         JYdssufb7PX3V56gKDSoKJ8XaoY/zUUbidH0EW7QBc+3ADxjyEPP94K+QQxjPnR46a5D
         RPm66OKr3NCt6YnKMa1YgIAtn4jr3DXM91OJbJTsbGVw0l2cE7Eow/kE3ksp+EwCYLcD
         CbTNEK11+TDkq+zQ6AJSpOaw2bpXx0DcGyb3R49xD9nWJOoDzi3BiPxMKqy/Lta20wPx
         n9kw==
X-Gm-Message-State: AOJu0Yzjjfc/exTwfSySdfDWKiuFzr0DDvV54JEF/kAqZ3f9RpCX4vGj
	mzo2CV9zeYyIprVc0P+KVBg3Q/khDe3d8n65UCT28WMZgMtv7T6xYCPLb32VwWGl
X-Gm-Gg: ATEYQzydA2Q6CHbbrBD7fH/lsxpYjJ0k0F0e1GE7Lg7ZRc7CtbjZl3jcu1fBYCciHO/
	urF2eeehdrzKNmzaB8IJrnQbs6uNqzAz1uXZ0kH1T4GDGhyVvDFpSwAtuzypEHCsm1YFLIfUyi/
	6eyz2IgZPnnCjaSmbqT8Z7p5M7s7xMeKns9XzE0BvZyfR0j4dBzZE6qMcqom7BdbpPE1Y9yCZgo
	jTQj+p3Z0tfi7wNKxnZe6TFRuG+wu65P+XNx/kLQnpHdc5UZ62ZDQvqlaeZNaHd55/1oV3MLwJM
	8nmGB+WPpzEBKIR03BWJNuG55SdpSKZtrOT57pu1r/zGnK4twHR706PkYvhW28Ku0n6fSp8dlld
	GnykvgoiDoHtqWN7Sub0PXtX6vWw3hFn7ANnGuKgZrAPxyDCTR2AqZVYBV0rhbpn7aJ8sRxEc8w
	nG8PizncmlJZccGHIJiWhZx1ZYsdX2DttnX3283jphqoQTYs3P6XtS8JG9
X-Received: by 2002:a17:903:41c8:b0:2ae:ce22:2a7e with SMTP id d9443c01a7336-2b07720fc80mr78941985ad.23.1774069652535;
        Fri, 20 Mar 2026 22:07:32 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836554a1sm39342135ad.53.2026.03.20.22.07.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Mar 2026 22:07:32 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: newajay.11r@gmail.com
Cc: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: Re: [PATCH] erofs-utils: fix resource leaks and missing returns on error paths
Date: Sat, 21 Mar 2026 10:37:25 +0530
Message-ID: <20260321050725.60268-1-nithurshen.dev@gmail.com>
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
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2895-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:newajay.11r@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshen.dev@gmail.com,m:newajay11r@gmail.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,kernel.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 24EC92E34D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Xiang,

Both the patches LGTM.

I tested the missing return by truncating an image to force an I/O 
error, and the FUSE daemon now correctly aborts instead of hanging. 
I also dynamically tested the memory leak fix using Valgrind with a 
10MB file and an injected Z_STREAM_ERROR, confirming 0 bytes lost.

The only note is that this should be sent as 2 separate patches in 
the same thread.

Reviewed-by: Nithurshen <nithurshen.dev@gmail.com>
Tested-by: Nithurshen <nithurshen.dev@gmail.com>

