Return-Path: <linux-erofs+bounces-2928-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2g+iAaCZv2mv6gMAu9opvQ
	(envelope-from <linux-erofs+bounces-2928-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 08:26:24 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B922E880D
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 08:26:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdnsl5Wgwz2ySb;
	Sun, 22 Mar 2026 18:26:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774164379;
	cv=none; b=cpgZzXqMbZby4EnxyL8XdSGBsdLQkDesB5dGzPOWcaApoecYOWkMr+0uIsFaAQPNZPOtrwkM8RDNRVLzcqcS6mN6dEnmvOqQCGvUK8pKKUA7EEhVZbZBPXSRJma7IRDoO6ws0VQbiYgkV4V+aMxq0nDdMFUHof4cytY6qEXXlGqsjxINuXBGU9O4MylJ/qOoDuT8LPIHNwv14WDUOYjSayVetET8JY1iwcuJq03NigBozN3iO6BCPPDKeDZSrAwLSq21ujTINKfdp1noKPZvHT+XFp1InIopxGcjy8tXShba9MBN7ku6OpKv5Dww9llJNfYVnNd4YfOU9YoI5iIzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774164379; c=relaxed/relaxed;
	bh=JVg1zuJ+C9Ku6AKi1xL9dIuAQQ1nGQPCr3ZL9ocStd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvMkqAU2X0zWreuOOQa6yRE+sS3fu+FYCWJZLUcQ1JkJZph0hIlWdhkibPGp8YV8HYfGPQVhc1eUfvlpHglBiYg5SNY3Ik3BosgpMcgw5m+GzFcuKyutbMnAkuT3TGqidnzGpkarXPoPOAFKNcbNI2YZwcqYDmKYxLIvYd4ymr4hgvJn4424lRey7mHqz/kIntaWRqbkUVevPFCE5Tbgpp5oj7HLYFcXiT+n9HuPb1FIsxwc7OHH4U7L9c18Rbr76k4MvMp71lQKfOzCX1YW0yc90cbEOMMUaSetydjSvsn8MOesRiu1vsVFbx9CMXYoL1xF5wSMaSz+hrbb+PCdEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Cxch1+6A; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Cxch1+6A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdnsk0g09z2xb3
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 18:26:17 +1100 (AEDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-829ac4670c4so2403252b3a.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 00:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774164374; x=1774769174; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVg1zuJ+C9Ku6AKi1xL9dIuAQQ1nGQPCr3ZL9ocStd8=;
        b=Cxch1+6AoczgGkT/CI4zwf7c9DgB4oYIOaaObKc/SFlyJ0zwD2wjKs+pHFBgmkTLCg
         n0pvGN3SF+p1PMh9eeSuqKV8MXODKsPbZBeg+3akqNDrOJCqDAMnmGx2pzVbtPop3ZYM
         x1N43Dn91FI6wMZ8qH6YaAaST49281kT1/G/QePVpYLxKsEqW/X3rAepd+3CNyiqEBke
         0ZvGvknpbZzTv93ochlXAQiVJgvss2Sa21KyIXBeuXBHKCuzGiCMgYcWWBw2hGLAm4Vm
         +HAL2pSjoGshtdPKbat2iOJ8uNZ+ZtywSSm5DD9iVsGPUEoS5gzAn2Ki2uqJHSCEPyyo
         otWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774164374; x=1774769174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVg1zuJ+C9Ku6AKi1xL9dIuAQQ1nGQPCr3ZL9ocStd8=;
        b=mCrW+UdQjCgCzlLi+ymyXDLT2Bw87LRjeA3Y18lPk0mT87FXYPtql95biL+98645aG
         bkbXHJyV3sHh5YepDfDVeGIAjEHIQteTfU5l0oQz9wpk12fZkgIf5Xsm0JnwZAyMTOra
         X11JKsfR12w8kPZeqB5Gv49wxrhdFQMyfiaO267Pp2tBL8Ga/+ORlnOYxI/jpKV1Om5i
         Uu0VsOFDPxoJGxNZJrlcjNHyWeLmlSt7Urny1Y7RLOmAWVDT3KtqQzHVK964fqp6mX99
         lTdq9Ka4S5KRW59tiyT//kVcfUcw3a118QoGfgjCRBzDsA5qHaQSY32tHL3C6avBOIVz
         jqdQ==
X-Gm-Message-State: AOJu0Yzn7wDZe5vU7MiEuIemXBueaOUx5U0E8jCtBPEjVRNvMqS6JaDz
	tR1GD8/hy60gXtyfEf03Wm4F3EgOVztWGKk+yDOukAgH+H7PtIwSbjrJ
X-Gm-Gg: ATEYQzzoJ3lq5jgBFbJluxMFKpVoqmUGdJHWIGLT8nwvOh0/SYc6HgoXSalTuh0T9Nx
	VDYWjj/mxhC7kxWOAFfpFY8bgKimFz4uxUgZAfT0FBIlEeiKldovxPlYJYiR61WKmKs7pA4IGFC
	UFZCdjbF1BwB/fXjO0n5JLmw6zGh3vwubSl73LwQ6ON3VZ58F5Xd8WBbozvXAME9AtXdrwyItRq
	QYeL/8WLpAUWrbG05ffMWBf/CQVXP8YeB0/9W/vi70+xU6mfKad+v4QUzfhM6riWHSHmfFw32jt
	AHwi0iDaTHgQ1uATr/e0LY7IOuZz3KUxUIWnlfVvYG0PCoUovdw3v6VBSbL9cZNAgTR7DpG48Xm
	wCLa0BWGoeGhFzx0np+DsaBVPjx2Lnj2t3z3ozhnvalVEWyEFfueP+exgzoy6CgHXEcnvMPsPv5
	K/JkowrsNutDylNQGg+lCaT4O+0nZyikUGEA0ExEi6AbGiHYdG3WUEGbAK
X-Received: by 2002:a05:6a00:b481:b0:82c:24d5:21cb with SMTP id d2e1a72fcca58-82c24d5400cmr4595066b3a.8.1774164373985;
        Sun, 22 Mar 2026 00:26:13 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da3easm5866541b3a.41.2026.03.22.00.26.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Mar 2026 00:26:13 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: newajay.11r@gmail.com
Cc: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: Re: [PATCH v3] erofs-utils: lib: fix infinite loop on EOF in erofs_io_xcopy
Date: Sun, 22 Mar 2026 12:56:08 +0530
Message-ID: <20260322072608.2656-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260322060358.1495-1-newajay.11r@gmail.com>
References: <20260322060358.1495-1-newajay.11r@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2928-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:newajay.11r@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:newajay11r@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 97B922E880D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ajay,

As a fellow contributor and reviewer, one small request.
Kindly send the next versions of patches (i.e. v2, v3, etc.) in the
same thread to keep the mailing list list clean and easy for 
reviewers to follow up.

Thanks and Regards,
Nithurshen

