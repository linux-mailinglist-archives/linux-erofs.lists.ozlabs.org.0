Return-Path: <linux-erofs+bounces-2799-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCoGNxZMuWnG/QEAu9opvQ
	(envelope-from <linux-erofs+bounces-2799-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 13:41:58 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33122AA0A3
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 13:41:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZs6C19RJz2yh4;
	Tue, 17 Mar 2026 23:41:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f2b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773751315;
	cv=pass; b=Nj25SYWEQV8cCVFe+taioxFuQeH1vzLdX6vwHLDoRTiTU5+Yi8G6ersJIPcBIe/E1ADjy35zl9YodaG4z5vT/C9mN9R1f8XlMEwyZ48e3SZqmf0j5YeUUJ+GWOkibJd1fa30sreO4/+VqQBI4Lw7iw/5Au6tUcmL8f07JtC4PE/81jSFKOkWO7fT4zhxJ60yT/2c6hcCVr94m8cCOQW9wLyFNpjZLCEkO6PQjG/qqOMG4h0rhU9eKrVfN47sUvFkOHY85KL9y6BIdWR6nX8WbeM1Im++cB8Uq2hsVvz6XWpvoiUNygN36O6dszb+osJscKRWxBG+tERerojE7G6s2Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773751315; c=relaxed/relaxed;
	bh=AvjF7OzG3H2Z9KoI5W+4BoH2Eg2bZt8d5JoB6COPHU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VeOkwk1lO0bdb/9QR/JML+sQ6jDuy6JzKYbG0Te+EMSd6np1NYz9YlwqGHmbjNeju6htJCNYlUEBf0Kr+W2GumQHqherbUVse77hIMLN4V48o1woRZz7oy3tjYs8PYUphk2aVChLWmUCQVy4YO2plpIxut8wYz6QG/NJD5M+U2A0NIxWjxJkNMijFGMk2Ia9iOxQeGxEejE6aqDdNI4CgslRRHsJssxgfnJD/I41nFGi5TSwiBspPky2+Mqz1EMMtUU4sRXrNtYkEijJd1PJKoOCMlALTiMrBM4mys9wKdd8huUD11qHFoDsEoy3CDiDtmHRBQwVaC2BywWGbbuJGw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QhJbcyRG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QhJbcyRG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZs6B1fSLz2yfP
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 23:41:53 +1100 (AEDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-89c554c0d7dso2702686d6.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 05:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773751311; cv=none;
        d=google.com; s=arc-20240605;
        b=Px1YmPNVdZ4i1ky8BtPXlqhM34lIgk6E1EBGEq+FhWPsJ/Hhgt5Mh1Tl2CUTNg2yBg
         tCJTRtwd76OaTIP0/nMTej9BJsH0ig9v7PtDLqXuJB+UMvUzB0NE9FyZVYfe24222vbZ
         n0OO5rQB+pDeOqjTE85tPVqx8RyAiDCWDFItJ4KX85pI1JWALBtzowAOGu873ZLlz29B
         N9IwZQMhRItfJDWc8UDqaro5WIHndjtT5iA6HaC2RCCfXmQrqLmLGFFuWRK6tKvlJ1z3
         sZzn1ZydhCE5bTF18TIW6FkLKC6O92sOczjpWUJ6uwuO6X6PyiwR4zsM+SpmyVSHQGWm
         A4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AvjF7OzG3H2Z9KoI5W+4BoH2Eg2bZt8d5JoB6COPHU8=;
        fh=MbNNyKNJAT9O2DmogO2mgwrEz96kfBdMTN4QFZAjVhk=;
        b=KSatnJ6sPCJF3n/d6uk1icPFOBMufN/2UD4sGMDJBkBVlWV99MScJ9CBT+Jr+YWuAr
         tyaJQKGl0tCelCLXIWI2vmOs33C0W++LmE2Tp0xetwLHpRkL3nYkgoztuMMk0OlmO8Xq
         sBfL5f65VvMSEHVHFLCKdWv7BJHVRHdB8Qp0pTz8gmlDy2Cr3xEusd8xKoKAOYKeMibk
         sMepd972jX2Kk8oyjHzGt1L9I/FhAlGhImaWDytugirZoZp3+a95w35bMWcEmLDRJb8M
         1tJn6OCIQ5rnLtH9gVCmaWHAkFpXM/KvdNsK+Vmt6BoIKQShXk4G2CEwcZV0ia86fJ1I
         q+LQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773751311; x=1774356111; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AvjF7OzG3H2Z9KoI5W+4BoH2Eg2bZt8d5JoB6COPHU8=;
        b=QhJbcyRG9NDi4uVf3Dr3ny/kOyb5xo13TYN5wLdfAPtQGLnsQ4EEIjDIiNu01obJBX
         1yFJbZLsK9Bg34a1SIjRX/dLbh5hPWoQRyV6XwV2d/RumfdY3vY919NU9eeXJzau9fcA
         REP86dftGXdeDuxoh0XQF/x00ZBdQIMgyxoo789Sd71aylsjHGuXgXWMMcn09/Cp656I
         dMTcL90DQTaERV2KIWTW+EMC+td4pwRFZHyxQuacxUHIHqAXCU3cypDj0xuGTQ7YFbs9
         jO+7lnsxw+neamV38RcjWjjnn9rV1o2EO16jHdRy5gLs+JX3NrF1uIRfIrM4m5S/D++X
         Nqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773751311; x=1774356111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvjF7OzG3H2Z9KoI5W+4BoH2Eg2bZt8d5JoB6COPHU8=;
        b=OIr4FZ8WxiiUvv/w8E9X1FtPnlcAy2i+PhlPA4uGZdAxlrsGpmKb8pREw0FPpGMvUN
         ZnH7/hqf/yhPp6cn35Eqy+zBf6P9U2TsdHtlUZK9xgbA7yfwx7M0M3tQkAefXBpaPUjV
         e/Gn1Y+ohlbQDnwpm0XU6eoIUyD07QxSUKAydvcSh6gxjaZW+H+W3vVPbHzIyF9v934u
         m3B4BqDsPWutI2+Q9jGaUXH/TR6oLbNoAyYthGncjaxYlGR1az/nexMoOhGqFrSQGuqs
         CnGvP/cnblrxKuhk1DFOVKTUilChpHgF4rLdYpGFhrxstX1o2HfT9r5QeLhdonNtS9qJ
         qhBg==
X-Gm-Message-State: AOJu0YxauVtmmVdx8FHNY6ztX/kEnEmk1tUllQfaQuG27jiihi3BCSfe
	bFRwVHcU97nizOlFSBmkLuSiGRwM7gELEnOYakz5bu/qRQLmhGfzHxMFs4jQ407ZmuSo/Hcg/Np
	MrqmdjizrRpoukg2QmHHUyud9VKkKkZM=
X-Gm-Gg: ATEYQzwtoDhPnUnW7aqOKVg9RrrhqXLAz9X9QDPo1fPwvavoH5SBgJeb1RDAQ7Xo4A8
	n5DxAAG/Jh6BbC+JHvR8LPm/D1IamOEJvhglmeGZiMHY2l6EaYWHv7hSTgzt1kLK28Eo8oGRTzP
	Bcuw2prOJbq88tOx+hRVE9tatMwd98sUPuCY5xox1G6mu4oO4ito9B1lznsrxVUFGGbqPSBGWC+
	K0a1uW6P7VTloaregk0R8163vGrc3AXl06M7lFPFmgiG8VETbPHwtxfrXgrjHOq1W1SagmAC6Z9
	b3M3Vn+0SyIlE7KQMkL+Othnc8DmpdYBRpHRjPW88QC/huDpRFkDH2QmW4zZWczqYI8WWA==
X-Received: by 2002:a05:6214:6112:b0:89a:50b4:bc94 with SMTP id
 6a1803df08f44-89a81956af0mr143911506d6.0.1773751311141; Tue, 17 Mar 2026
 05:41:51 -0700 (PDT)
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
References: <20260317113021.88187-1-singhutkal015@gmail.com> <c4b2f0de-c3d3-44c9-992c-4a49c4b8b23e@linux.alibaba.com>
In-Reply-To: <c4b2f0de-c3d3-44c9-992c-4a49c4b8b23e@linux.alibaba.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Tue, 17 Mar 2026 18:11:43 +0530
X-Gm-Features: AaiRm514mTN8XNf1VKSFCJnyQgXr_iHbAVSNNqyxLqO9BrDTQ5mX0kYHMfJ1n9U
Message-ID: <CAGSu4WOm5H=aD4cBgsXeydJ9Lna54g9EQRE8oZOZGmMRmycnZA@mail.gmail.com>
Subject: Re: [PATCH v3] erofs-utils: lib: validate h_shared_count in erofs_init_inode_xattrs()
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, yifan.yfzhao@gmail.com
Content-Type: multipart/alternative; boundary="000000000000d20ef6064d37a82e"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2799-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:yifan.yfzhao@gmail.com,m:yifanyfzhao@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.991];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,kernel.org,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F33122AA0A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000d20ef6064d37a82e
Content-Type: text/plain; charset="UTF-8"

>
> Thanks for the improved commit message. I have sent v4 with your suggested
> wording.
>
> I would like to try submitting the kernel patch myself. I will fetch the
> erofs -fixes branch and port this fix. If I run into any issues, I will
> reach out.
>
> Best regards, Utkal Singh
>

--000000000000d20ef6064d37a82e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><p>Thanks for the improved commit =
message. I have sent v4 with your suggested wording.</p>
<p>I would like to try submitting the kernel patch myself. I will fetch the=
 erofs -fixes branch and port this fix. If I run into any issues, I will re=
ach out.</p>
<p>Best regards,
Utkal Singh</p>
</blockquote></div></div>

--000000000000d20ef6064d37a82e--

