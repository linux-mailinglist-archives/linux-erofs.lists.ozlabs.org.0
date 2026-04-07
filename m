Return-Path: <linux-erofs+bounces-3210-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOWaKBJ91GniuQcAu9opvQ
	(envelope-from <linux-erofs+bounces-3210-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 05:42:10 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1153C3A979E
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 05:42:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqX7f1T90z2ygf;
	Tue, 07 Apr 2026 13:42:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775533326;
	cv=none; b=ZkjQ+KjlZFDyNhTIrsJ/nzMYEbsNBzBsZkdjqQJZ4u4qOajlBTKzVfR+EBqKYXwJ661wV+XCPMA8WMKjQl/rp/nM9B/OPRUstkw02PtQeaAgoBQwQQ2wgjzVsgdoNf63khNt4beMRRLpGt3K5xVQTcJ7mo9NHIM/Kq2AmHeCt6l1WrK+tKfkm/xjOK3vwZcwrw6ZtaDSByHgQeKPykhudX79Iu4vcDrO+Z2GDMgWkOLuHrCubSHSn2/pbohvYPZ/aZYWralgXqfw5uoF71+/vdP2K/63gTZThaUh9rscCoICZBZYRxCPtmTSjkDbwg8QcJK2ZJM5emwZ6Nti1JMP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775533326; c=relaxed/relaxed;
	bh=LbmJOUgf0ksj7d8pZVxK9W4zivnpDobh8nwzUYksIlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnWyIEJf8E5sHzM+B3LeQHLKPyAdKA0HBUg0lDo1RFEKDboEPe0tV+H0qA4zMJerS+FD1B0z9SbKoVS4EbHyBqlYD7lfgEaaKWBc8SlxCaObrrBZcSOLLVlFCvX5YYFgSWoFCWejpettMlIkfhmIIgDGTlgRhjX51DAA46kcaoXcvIr2oyzlwjcZlQKRm+aGE3KN5DimW5hIQzhXn0M2p5JEPqiwqKg8mERt5PsQjKZpdp77a5xkgIfErd4CIiqdSfHz83Di9TyMWXdLSylsrJxIN0g2a8xaz9NKWdeBugiZi/cmNhJXI+ws0rw6JHOwFuZY5QE9lZEqkBMMcEGgDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MPSjIrwZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MPSjIrwZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqX7c56rMz2ydq
	for <linux-erofs@lists.ozlabs.org>; Tue, 07 Apr 2026 13:42:03 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-35d90833cacso2663624a91.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 06 Apr 2026 20:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775533320; x=1776138120; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbmJOUgf0ksj7d8pZVxK9W4zivnpDobh8nwzUYksIlY=;
        b=MPSjIrwZPDo7oerJ4ICJOMSxozsEOMCRMJ2gNpCcoLPgPvKCuencN7tubgGzd7C+tY
         olhWW06m6+dTiWg5A1S7n1gT8dMJtZFDtaTMHDlpnCjw7/a2UdLi5ARs4Hwag2gRifMv
         rzCwJsK/A7QYbqNTKUH2liJJge0KER26cQugN3jKf68JvLk+FQSg2n+TXibGvagHEhdf
         QQYe2Wa8qTLXI3mw9pv5RVzR2KAR/itQKCZNWAxyyd1A5QUjUy22HN+VEYRfM/1f1BJa
         W41GafrFktJhluYwXs6SkjestVywoggY4i8Xa83Z468gbVAGeP0xuY4KsSHQoCZGcPdQ
         ptKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775533320; x=1776138120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LbmJOUgf0ksj7d8pZVxK9W4zivnpDobh8nwzUYksIlY=;
        b=qIoGuS1zSbRt9IkNJPEjA3t5R8QTzkxs8n7XTku+zEnMBIUNSs7B9JsKQns+xQbEqF
         tVJK31PDwBixKT8d1D1o5U4sGZpfeGRRPlBKCpqd/uStk5uwW3DQqQefWu44+h2Ur90e
         C8maTSpkMC8zVyrxNNsq9u9tSYrfyF7DCQgBHfC0mauQm6lCA2p6uyuMPA3VvP79zfPJ
         73iDI+JZ6tpJbyfnWtyJ5W9nnDhxrrliBgGJHQFjOl+IwPWlKeNKx5T0tPImBTTPzl89
         Jxy2Xm1S3y2A5mPR7udUrMbahYS6+w4FHMdoAfo/1bBco5U48ZSol6QDT4oRze0L1B4R
         LnpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeHUj0cJvAF29B9we+4iIom2nUNM5yEP+xrHfdJzVLAtMspo1AB+iooCndvwnHbiF7g59WHUxPyLVS+g==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwY3sRRsYFuvLqMO9zl6BtmP0HrwxBC7Y1jGmEg8/ISC+cb2Kyh
	jXUneMfmj576DeMYk4KmJRmuyQmAVcFBcxwBoJVpq0ty3w7SGwSShbEcNNaVOw==
X-Gm-Gg: AeBDieszsFO73YfMK+bMv6LMbBjlcGkXuSm41Hxy9JQuHQymCpJb5oJZdckqS+6HD0Y
	zhVomsmxBKxJ1dDhCzSXOlDq0TsrVUeLd+0SzrNDwhRdpVbjQ33bSBjJQNSaKZlP/GfDoSKmuuQ
	JvjqF4YZ6ba9y9liaS/thXBQUhPAG7KbIx8hhJM1HRhTur5oyd3XEyZCf0WpBp9XS1asZATPKfi
	NyZeGNbGtl1UlI1Pf36P8L4ofSV3OuCwxxOKnAJAn2xCG2NdvkpUuNfBgXpdlEEjP2Cm60UMpCQ
	GNFZSiXzCRyME+I8zUtWSxt8xIUEbysWlqGYbR2ZmWK7dSWArqlIKLLMrc7ShkFDPgu7JTdV42V
	uFYGzXe69aU7k1bwUxkjYfemf463o3m1hnGBbqRziucRR6num6bngT5rSZsucT/reEwkL5npKRx
	lkbPDScKYh65wO33CNHBd9K+dW6jMPta22U9DcjNVY5Yl1XO4=
X-Received: by 2002:a17:90b:394a:b0:35b:929f:7e8d with SMTP id 98e67ed59e1d1-35de696f281mr13378152a91.14.1775533320429;
        Mon, 06 Apr 2026 20:42:00 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe93661fsm20704216a91.11.2026.04.06.20.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 20:41:59 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH erofs-utils v2 2/2] erofs-utils: handle 48-bit blocks/uniaddr for extra devices
Date: Tue,  7 Apr 2026 11:41:50 +0800
Message-ID: <20260407034154.5142-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9e0696c4-95ff-4365-aced-2f67c7f08c85@linux.alibaba.com>
References: <9e0696c4-95ff-4365-aced-2f67c7f08c85@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-3210-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:zhanxusheng@xiaomi.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:mid]
X-Rspamd-Queue-Id: 1153C3A979E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Gao,

Thanks for the review and for fixing it up!

Sorry for the coding style issue -- I'll keep variable declarations
at the top in future patches.

Best regards,
Zhan Xusheng

