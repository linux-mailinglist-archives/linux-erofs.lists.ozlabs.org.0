Return-Path: <linux-erofs+bounces-2867-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0mawNvqfvGmF1gIAu9opvQ
	(envelope-from <linux-erofs+bounces-2867-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 02:16:42 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9752D49AA
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 02:16:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcPm50wwkz2xly;
	Fri, 20 Mar 2026 12:16:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::436" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773969397;
	cv=pass; b=Zv81Ry7ZhRvC5c7xMbjL054QMur/tBJ4iHBdMrDIMtvrVs4F5eIXroXTLKI5HiuVRMf7fYghvuq6FDbbJ/vE+QyrexKKPHqPYF70FQWQ36ArEFIMHJLpnySKjlsc0PyuMFPXQXYRCvklCz8t0SsYPC8dTRwz//P6v3ZwOUZEjME6FySPDhwxxh2TLOObNja5LFWNovjUemSlaO57p1wlRHh8UG0ZDEyst3AwkMQX35ZLu7kFBC3tthouW4NZprQ5bM0NcgEf01U6WDNmKMuKIovt1SdRajRuNV3s3Eqm8CaByRWuzODzFrP65AG84F5XDUv8WtePZh0iY5zpL5plHA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773969397; c=relaxed/relaxed;
	bh=9L7/biCILA5vAg9HWxxQ+bPzzSoW5sP+z8LEA8sOro0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9KYv/ZGFnBIkjCWELESYfG+arlmQBWsL+xbz21Y5f74P/oj3lEp/ejholj0IsGQEyzAz9/mGrdS1UWob+6HvfsZvT8+W7VEvMUw8GroGMuiJ7Q33idV0XDhCSxhMfTbCiv/sRtVWLo+TTIIDHSt03xjm/KfqcZmHpHA6DrIR0QUOywLI/5/4wsAo95clgsmFIimQUc1M+cb8gfvJ2XWJWSd3NTDfw9rda7NeM4EjFSRIR/ZhzTTl78X9Idop7Fer/dVNClFDVT7DeLh9PTpVNpF9MLCh8iomGMYMNykXD3BrFf/iMsae6/gZ1TieC5hvcLsaF2kwa+fVx1UkKsbFQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SeDweoLV; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SeDweoLV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcPm36xmrz2xN2
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 12:16:35 +1100 (AEDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso127090f8f.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 18:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773969392; cv=none;
        d=google.com; s=arc-20240605;
        b=QLigaYAgz8I25fnLlu831QlVYIOJSpJXwOoxnXaXaD33EVkDYvH5w+fXfINc4txXcR
         hC3lgG+96PV0d/xOpyXxQUalGv6BGJxJwjaAaJo39yhW8iVbf4+rK7Kid/KQ3m+GgcLw
         VKxQFH2WuVO4lMSysGffhCw2IPtvO5afeK22r0fFeiErJ9/aSkVn+TRRgCRTRBizeCud
         NhGlKnO/JhpnqoSTwf8C/12aXnvzCq3a8LvksbWac5T0FV0KIs8zjzs0vhGlmwu4ZhPA
         wXMbofA0NiKm5sAqmkEo6RkVsFgQyG7Qq8M1a+otb51j29NTXBeOa5HlAfq1l6kHzPlI
         Zavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9L7/biCILA5vAg9HWxxQ+bPzzSoW5sP+z8LEA8sOro0=;
        fh=3osejVfemnUG3t0gI4QUiZWTVUAl12x8I/RZJn/ocFw=;
        b=fxXk7ZGA0w3PKzL5bF7Zpr1V1cTSuYnc9zPBWYLtA8ZL/Rq24d5hKyk6Tzq7feJQu5
         qCfB73sDTjjGH9Ey2kvNkPBUtOm5OQluLBAkh0pYY1XSL9jvRKZkq5YV3/cXtT0WBb+7
         rWuxO74VwLpw8qlTh9/Ur3zt8a7a1nA5eDPLXRZL4L/4iCUnX10MHnO9bsBjqefMlntJ
         yr2qQN8qZltq4uSTRIfyNVL1rPo3qzcTQ/3vn4gbxbPuIFx9geQpLJS7iZTRZ44qYGrb
         kONFeOOW1+GK3Lk8xIbTPYgQdseuj0nsbdsU8KnRTDjfi4+o4vuR9A3cWZZECfLcRqNc
         YTyg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773969392; x=1774574192; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9L7/biCILA5vAg9HWxxQ+bPzzSoW5sP+z8LEA8sOro0=;
        b=SeDweoLVUdzTneaKyEiynqKFBiQuxfL7Tn4aRtPX6eXRsGDxSqHnBq6nfxm1DDQw9u
         06CwhDsgZVIvir920mmgVf3sQQZ3bQ6f4xGhsptzxfHjyQDpkFhuqLHjmk1ISbbKfWnu
         xYsht5GRE6zqYpCszkkOK5PHmGKMgdX1a9sQHPuicdROwqQ3NhLAsK+ar1KGeJPyJwTy
         FdMdEjuSjJzg4GMGfYnVEMB7u98PXgrqBkUTEK4CpUne6inU70jEuT6maBX48pHNNpT0
         mTGe1aKfURINFIrvbYiSXOXNm2zUeeSVzyta1yX2Sp4ub7V97EF2tQqSaG972cQ36jdb
         0xJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969392; x=1774574192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9L7/biCILA5vAg9HWxxQ+bPzzSoW5sP+z8LEA8sOro0=;
        b=FIOizx4uXTomZNgNp09bsRFdyTUNivKkBx/zkdZmraRn3AAptRDRyXCw5XEaij6gmv
         pVWgNyiYGVcdGG3qwOfH2GSDT61C5a2T4+Xawu+493DD7rpP79NrQNT0iO/P534prWyG
         ocg5VzXXMIxU3lBbnVxPU/pj9LxmOC14rUHUmz53Tm8pIaIlVd44YNWoO143R3taBmZu
         3FZ4OFHcDxi5MT+G4rojisBILL0Py8gxPmPlKqrXAjNyIRB2Nv6nEc8SpwLKJJbix/Bm
         CrrqJdrWofWxSlGjavZehZ4jCrNnJu90+uXo3AcpfMlMVq7vJm8fIkoRmaDYk9iTbgNN
         CDZA==
X-Gm-Message-State: AOJu0YytMbgmCpVKT0qA3TZKUhkeiptwX8nBUUyFLhMRPiPz+7KjJup1
	08iJsUjkt2X8XJy0/XYrcvZ/2O002nTUGy6dkrquVmeGcc0r2CqavRPGqdOilfO45bsp0vEIPfk
	vflrfGI6JmeUW2ihmkj/+cdbmG6lMXYnKcikb
X-Gm-Gg: ATEYQzziBxJ7PQIU4m8z+ZpUdvYKqQcmWdufkHoPHTEDkMglVHIbmdXCIHm7Tuz4xMv
	UmvUQYIE+BLi1usKQHaJqyja0ynd1aa3BqsJ3TH45F9z1+mLlPrDX/zXVWhzub4ZIE80KMbYpc6
	lbBOZQgOyhR8ta5M5S36n6CmJOt21GgYHhz+R9/lUYIU8FPAJ7PBN8ELkOBHnqrrCP1FjLGNEHK
	18/neQtPwdmNAxwLv6jPpnZohw44hSoX6vEa+BbW8p5E6C/OwE/4AFYdu6aijr5uC4ukCCNWoXz
	T8UHqInx9D6RQuAFMZAn6FI+NniO3aOFL2T7rq8=
X-Received: by 2002:a05:6000:40c7:b0:439:ad4a:f40e with SMTP id
 ffacd0b85a97d-43b6427d1b0mr2170988f8f.48.1773969392262; Thu, 19 Mar 2026
 18:16:32 -0700 (PDT)
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
References: <20260319221136.2126-1-smsharma3121@gmail.com>
In-Reply-To: <20260319221136.2126-1-smsharma3121@gmail.com>
From: Ajay Rajera <newajay.11r@gmail.com>
Date: Fri, 20 Mar 2026 06:46:19 +0530
X-Gm-Features: AaiRm51r5rIdi7FEtZlLZLwn-11dVmnsjRkHuLMJBu6vgJxfUjWRl6meUbNFeD4
Message-ID: <CAMhhD9hbenqz2z2pRQ1EoSNttATsTnW9BZcgFVZ1VPCzAciHiw@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix QPL job leak on early error paths
 in z_erofs_decompress_qpl() After z_erofs_qpl_get_job() succeeds, two
 early-return error paths bypass z_erofs_qpl_put_job(), leaking the QPL job
 handle: - Line 200: return -EFSCORRUPTED (when inputmargin >= inputsize) -
 Line 205: return -ENOMEM (when malloc fails for decodedskip buffer) Fix by
 replacing the bare returns with goto out_inflate_end, which already handles
 both z_erofs_qpl_put_job() and free(buff).
To: Vi-shub <smsharma3121@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com, 
	yifan@pku.edu.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [0.80 / 15.00];
	LONG_SUBJ(3.00)[477];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-2867-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:smsharma3121@gmail.com,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@linux.alibaba.com,m:yifan@pku.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.971];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: EE9752D49AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vi-shub,
just a review :
I think the fix looks correct and it is the right approach but the
commit message formatting needs work. The entire description is in the
subject line. Per kernel conventions, the subject should be a short
one-liner, e.g: erofs-utils: lib: fix QPL job leak on early error
paths
The detailed explanation (which error paths leak, why, and how the fix
works) should go in the commit message body, separated from the
subject.

So you can resend with the subject/body split fixed? so It will look more clear.
Thanks, Ajay

