Return-Path: <linux-erofs+bounces-3212-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMkZIYu/1GmWwwcAu9opvQ
	(envelope-from <linux-erofs+bounces-3212-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 10:25:47 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA873AB455
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 10:25:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqfQp3gNSz2yhD;
	Tue, 07 Apr 2026 18:25:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775550338;
	cv=none; b=Uy8mr2TNz5mgRffLb06hZAYcEbNxRSBEa6IbGWbFHi+vDOUZojmJGVF7RuU800GjpMdlu5NCgOhBfaD4CIdjOSdjBehiPFpgjzSuFivhiYs8qh9r+sCklMQZO7GMsrKCctMNXK6IGdUmkUGTtJP1II/oyillgJKznF2fB39psOlBv4+CVQaSDI1z0C2VcHkgSVw1njkNi74oMwA8InwIDqSHlI+dAOC4ZSNo+GmBHrF0oevRhKVHD3t6ck0i294P881KkQ2pIysmMf5PANLE7Y1ISWaru1CVFGZjJ+8fo1Xf6G46XZiYp0kRClOv/kinBbudrugK2AOZMntosbsxqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775550338; c=relaxed/relaxed;
	bh=hKvRrG2HElR0U8r3XiZA2yBT+fFXBGJRfgbqulPnQMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnoVyxaBPJUOeiALMQiNSOAD6A+fOEW5+0NpEFC/1frRVemXSAGP5wrZhsiuQ8eepsj/Kr/uK4SK7T4tBbywr6oO3+0w3AuiPf0+D7eJXtbmWOeXZTsVOTBOAH1MlICA1VSLNWkU4hecpr0PmCMjdeJCuDnxDpaYX2XVRhJiFmlEuNOMJqG0Abqjr2NDkeqGKpYCKk6BrqOzhMk50tZ5oQAvJGeHuxdWzWj1O7Ao+wH7gKOYnCdD+MlEwbDeMg1MLFCJ8rHAptIMf+nQFE+pnYBG2UHtAmZu0yRvAVqOqoi2tQz5hPZ9HGeccCM65R7mPyBIfGVM5wrdZ5Uv98CPnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CuW68j4+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CuW68j4+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqfQn4qdGz2yYY
	for <linux-erofs@lists.ozlabs.org>; Tue, 07 Apr 2026 18:25:36 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-35d8e548a05so5192886a91.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 07 Apr 2026 01:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775550334; x=1776155134; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKvRrG2HElR0U8r3XiZA2yBT+fFXBGJRfgbqulPnQMY=;
        b=CuW68j4+6p33XXphJilLpbo+YwyFh4l0700p6kg3Py10kKxMpaYChpVh1HN2xNSlLE
         jpVaz9A3sucjOdeHDlQwtkuuBSfjRVu+b54SyFu/2D2p/lQ0QPmVWj0BMkj9q+N9851p
         h7tLLtDlhspIfgO6uDOAe2fXhkn6NiESOj6GltCkgtiDRSWkskQYVrPY4a+7Qib4mZAX
         XqL6ZLuOn6hLjpfZggXCWsw/+FPnpznariJFo3YiK9pWYbacj2mHKUQjZg9t/mRo6RFB
         SO/QvaKgmwQ4jSHpiL+eVps9KoJoYGFdvlNs3SPy2xxkuufeXVjbSzxaaHt4vwgr0dl9
         DTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550334; x=1776155134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hKvRrG2HElR0U8r3XiZA2yBT+fFXBGJRfgbqulPnQMY=;
        b=KbO2AgTfzGlRAqioxeQogjyrTw+fyG28Ifqg8UZ0tHtwdjy6Sr6lTtepdIjTz9tDtm
         IGZ7+e+kXBk2EAJbaCPCrCtW0Tn/UWFwMk7FmHfksTmYGqdxkGF0iS7VEZoDPkIwX1uK
         DAvAY9pfnvPMzx/b0OJunaGOZPtaMQ0SQnJfB6b9byRj8Ol3PbVdanwn1yZ8V+1GQMqL
         jHErs6TVmFEEKt4t30NXMQHvMvBiuLvz4bXBkiOPW8/UGCjOiAOiR7XyK1ucy3XUqzoI
         FC8Esy2b6YQStNQTl8j+3s42iltwI64wPRV/h3TKiL5NjB/QFbt2YwVsy1Jmbtd7ytwZ
         IMrA==
X-Forwarded-Encrypted: i=1; AJvYcCVydK9vbbUJOiCAbS3hoWaiBtTYnc963rv+CTDN4WHffJWd+nVlJc+GptgM9y6o0g/uH5ReCpoufAMBmA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywloo8Y2sXO+C1QIQjhtYLhInKFQXelMTzgyqpD43Lde1roqRg0
	PdAUYs6BJ/IQVxJhRNl+LuD+4oGsj2r8qVg3wua8Sl2Pomp0GoxzKaDL
X-Gm-Gg: AeBDies+j1BAUE0WgxtjEeHMT8Vy++fWiiulK1VZT83Jixu9BPtxkfhHOBAYY6pIeh7
	52Yg7MN0oyXM1oJZSLeBPZweHsdTUPvlIyRKJvM2ylRnavIgokdpORMKVSute7VgtB7V7EN7Wto
	uMSbE1hnB1KZWnd4dQQXIlM/eY6FWn2iPddyz74mvF7ffwaKA658B9DA+aYGND/c/C7t5uL16Hs
	AFhBWW0ShMcsJDa0ifoKOnlfqSBV9NhK7TcnwZj1fnC4C4CrwUT34OfDztl5p1Ml9DkMEnj1ZG8
	f6bQ5yW/n8pVWmlssP5ZA196KY95elO54evzxUm5o55H05aGJ8fp7UjdYZRMfj1o1NbCgMKX6zi
	dNZoopnL5O8Qd2tRO6rpO0nUNO4wA1R77CKH2PRLIbLMEtMlcYG938G7wbfFp2/T8L9W6k9FeIM
	XnNK4iCX+E+iNmUR2kDfLvHjpoILwh4kpjQV4+WeyjwTv77/8=
X-Received: by 2002:a17:90b:3c4c:b0:35d:95eb:879a with SMTP id 98e67ed59e1d1-35de6871781mr15578394a91.13.1775550334412;
        Tue, 07 Apr 2026 01:25:34 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe959886sm21703622a91.14.2026.04.07.01.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:25:34 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	linux-erofs@lists.ozlabs.org
Subject: Re: Re: [PATCH erofs-utils v2 1/2] erofs-utils: fix swapped hi/lo in 48-bit primary blocks read
Date: Tue,  7 Apr 2026 16:25:24 +0800
Message-ID: <20260407082528.8773-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9ba9a21b-f4a4-48e5-bc89-82f50f56474f@linux.alibaba.com>
References: <9ba9a21b-f4a4-48e5-bc89-82f50f56474f@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3212-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:zhanxusheng@xiaomi.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 0CA873AB455
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Gao,

Thanks for fixing up the commit message.

You're right — I didn't properly reference the corresponding commit in
erofs-utils. I'll make sure to reference the local history properly
next time.

Appreciate the correction.

Thanks,
Zhan Xusheng

