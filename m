Return-Path: <linux-erofs+bounces-2876-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO7xKdIEvWkO5gIAu9opvQ
	(envelope-from <linux-erofs+bounces-2876-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 09:26:58 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BABDC2D7371
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 09:26:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcbJY0Lh3z2yYY;
	Fri, 20 Mar 2026 19:26:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773995212;
	cv=none; b=J9xXsai5jGzkOI8Y4/Ywxq3I9kZNpVxOPv9bSEZRxIQltp86676D6FjxoC7JpC8PUZauHPUNxBvKkyJaq6TzUiPgigtLdttu3qc4Bw94cmRkPlm06d5WgUku/HTrXYQGvTXUqilyp87DPLIR0711yhNadX0OhV89wXiJlqxPoMwUmOVNXwub9uZaGCSjbyniDvoy3rjvtHegtJ6eEAvyOVTebi1kb6jcYm41PmulRzq0RltqgsQh8d2K3xrzXrca/ecjM4MGgsSlf4jFTCFadXewPHusnKPzzHmzgebsxIRDiQxxBsot1IQAfOAgt4lBWtmCSBScrOFIXGRcLMV7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773995212; c=relaxed/relaxed;
	bh=dibdthnCoAxOrZBhpL40zZyHDpXBAbudDajBYvicWJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNuuDrBPy9efU7jYT/QgWI+lOHa+zahsbbByptky3hQlLk10548/zXO8/qGDWjkbCMXjaWdFVcaLPY7VxISLkpwAh27JodgAa+wEr1CuPLW5TySYQ8AvOt3I09wfEkVxQyBwro6PRgjjheNGZgsG/bYLmSw+CsBHrnO6zRqBM3QmLwaJPymQgDzDQOw5xQVzSxjyfvvsr9RWE8iMTYMkYdnT2RpvHSrB9sot+lulHBCCFH2RrNCCrBeOn0bQFLOpzckIiqFrLN3FLLMAGFxbyi2kV862Iuy4CkXCtIrjVqdyDl/0HxraisYjfvlpD6TeL+WW+xx0q/vEaZYUsYjonA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=S3oY7sWU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=S3oY7sWU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcbJW5mtVz2yY9
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 19:26:50 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2b04e6a989eso11611725ad.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 01:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773995209; x=1774600009; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dibdthnCoAxOrZBhpL40zZyHDpXBAbudDajBYvicWJM=;
        b=S3oY7sWU/yULrAMG/YUqRa2LAKa5XYPzoYyh+6U1cirIYA1xzfyKPRa5nXCV2Q4Cax
         UKUEoDgMP+PsGFSUuiwV0LpltYkc/6df/lZqrfoRl/BSy7WjKgA27U9+oXP3ERBlJk2z
         MT0vGpAPzQpaMyHxb5EsXk6JWAgmTj0G5j/FFus2KHiBu6g8qeYq019bq0vhnos2l2TG
         9rydAC5kGEScmH1aZNkhXPAvCa9oJGWLGchHPmJ5EgO5AXT9iGB5QcBWQsSF5CQ+iI+I
         +x7K+mKYjJikYv+XOoOWlBYgDP22O7nSrfpfVtQ2vK771ue9Mgo1rmj/ajOlOzMA6Pts
         Lppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773995209; x=1774600009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dibdthnCoAxOrZBhpL40zZyHDpXBAbudDajBYvicWJM=;
        b=jKjnDVHs1jFfM6OaHMNCRs5lDG9S/m2c8CfLlZE8v0HXQDZXFM7ctGvlXAzI605mQ6
         /M84NdIL0mVydqY+Y2gkig7jBmTO+0aHXb2dHV3g67zU6k6skIRjQZTP4NV0QYxcWKie
         iTiP1bvDu+X0g7nbVa0ZTajg6VKFiSwXy3x2CSoACnaqC9JzHMwXHL8wWeH9BrHmqv3S
         Z8UCPg2d3Yj2AJxjkqEgOKbGxmmqVTPZnKTfJziXsNs3HvNrj1tBoZ3f2ajF1XD3RuLO
         hBCzHZ2p5nQEes8GGAYeTkjR2RD4WG2sj/zQ2jCul7AxB4EJh4un3AOTmWayLi9lFRBu
         5fTg==
X-Forwarded-Encrypted: i=1; AJvYcCU1xfOXb+cjsKSB8S2e3f7QHQ0yzjZTWhPt6EJ/qDy/O3SCeernulWOUJoKoC/307Bu6KdFkKtq9spTfg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzlOOYQHjdR/KJEK8mdnDvrtqBEbIIhqdIW77RW1AB8t0E4/L2p
	heofnVMvghSW0SqLx3h4rMFcZeUnoRFNwCxrUWjTa27JR1rDLtMoYLBa
X-Gm-Gg: ATEYQzxawBGbj4XwqlOBEIldsuONmZk/PMi97ANMtKtFSRm0PI8zDOfc0mgD3grE/s2
	bVwf8aN5wDb+uSbmeeNBEekB3FIZOkkxhg5sT28Tr0wuSe+eikcsFu0H1PYhs7Tbv4bXSVOfVX9
	F2jwQjgrvGVGLSzz2KgMS5RLdCTQDHd5r95WvbfokeuCqx6rrMZk4HWaImZbg4hmI8qtE98adiU
	E+7z0jKezCKQvgwy7ndWF8/3Ofi+R3w352PGgCiYy9vtaACRSA7L5lMhmgpp2YzS2A6yJe68OIV
	jOoUj80vd6lXCC3kurn//rtBsi08GTJu6YtssChLMuUEX6s7puLYBQ3mgbE7zwcOkmE3xsfqp4n
	GFfaIGbL2nPpGqVf06hCeUV1/3Yv1LEMvrBoZxd9jbM7yVBK+0f+BL2DL2vguByotB29g7GQGbI
	pZRIxOZF1Mh61iv5dJjIN8etxjTlpehel8VFmVOJJaGQV/iMxJi2ipHihrrrOTFSJFaJw=
X-Received: by 2002:a17:902:da87:b0:2ae:aca4:b120 with SMTP id d9443c01a7336-2b0826c3a79mr22449845ad.4.1773995208593;
        Fri, 20 Mar 2026 01:26:48 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366b5besm14981645ad.55.2026.03.20.01.26.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Mar 2026 01:26:48 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: singhutkal015@gmail.com
Cc: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: return error on ZSTD decompression length mismatch
Date: Fri, 20 Mar 2026 13:56:41 +0530
Message-ID: <20260320082641.61679-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260319101721.17105-1-singhutkal015@gmail.com>
References: <20260319101721.17105-1-singhutkal015@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-2876-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:nithurshen.dev@gmail.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.994];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[linux.alibaba.com,lists.ozlabs.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: BABDC2D7371
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Utkal,

This patch LGTM.

Reviewed-by: Nithurshen <nithurshen.dev@gmail.com>
Tested-by: Nithurshen <nithurshen.dev@gmail.com>

