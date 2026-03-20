Return-Path: <linux-erofs+bounces-2879-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKICK6IYvWnG6QIAu9opvQ
	(envelope-from <linux-erofs+bounces-2879-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 10:51:30 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60942D84B3
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 10:51:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcdB53dr3z2yYy;
	Fri, 20 Mar 2026 20:51:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::641" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774000285;
	cv=pass; b=I179ZO4V2YfDAU6kEv/Pi3jzUVzuGydGl/QrdPxfNUap+6iJGuoXHSW9nWWZXsrokDNN2C+qudKIk4QzvTZ9rhO8B/FldJZZmaQKLliLH24jgbQJUKHoUms0sBkVnWpnWEbrQzTH0CvXivz+zETQl+cAb0xOHwhsI5mp8S8jtzyj6K1bIt+uABYlZ2Jgk040Zz2f7rMxXeu02jOZqJgn+sdF9nj0igBbAPyWO+b+vKpLHhLnJvViR/X5r3rFJyEA3XUn1orI2N/hfx4Esejs72aYemAHObgglG9Ikoq1ageDBhS7vSVstE3S2oNGqZBrWv6mhxI3dfehZ4j7ROr1BQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774000285; c=relaxed/relaxed;
	bh=UDJZUpTuhl2PI7c5/ENec+CG5ZeKt7minIt3HLTdMk4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=g3iltlSRbjz6ljNUyAgqHn2+dWkLzReiSN3yIsh9NtDh5S73WzIYlI6ZGIDJiRHCgecBBJTJEtjkVqjtdmXPzf4H2xTsG6PVxfEwKRqDtJw9N1fMYILPbH+xuSssXn/VEl1QYx1TAYeBpAKg1o/ngXQ8svgswbmcW/lDScXpwGSfDqrdjfQUKsKS5qiZAQYNbGVbI8vGB+idulghMVBSv+uZcaj22aTSMp81uhj1RdWuSAjEzDN/jlN8cOKAkvzO2iwgUO69A6HQwtBpvyWOvRyyhIbQ/ERLcRjC6dB+QRtvU6MEKiXwALcn/ZgkU6hdbivE8c4xcyzRv8uV16iNMQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PJmINcke; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=kamranalam4555@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PJmINcke;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=kamranalam4555@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcdB443LSz2yY1
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 20:51:24 +1100 (AEDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-b980785a0bfso272523866b.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 02:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774000281; cv=none;
        d=google.com; s=arc-20240605;
        b=H5o9xRWLwfUTmMkwLa+sqN0kvdhgBGWNEwXz8U3h9C84I1B8p21s8R5OGJK92eRasz
         utB3a1IWd7l2DWmPqac5rahlviBWGv0LzWaucZNd3bjQtsfc+WANzSAI5T7U+zT2qQEa
         BajJGis2SmvEuny8yNTe3SUqA8YYSr12+qSLtszEEacKKVqFBPEDPu4qGWuJp9IWaHm9
         KpKv5UHYd8lz6RYBq6s4+UF0tCZI8vKJ1bK/bQZCWahfPl0MXbeidydhPpL/aXj9fmNL
         YwMPORCDgonsqChbtkwlHAHXQGPgQGsBhmLZ4ABDrviFppZ5LXvNnKFlqCYCs3n8XVvv
         sc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=UDJZUpTuhl2PI7c5/ENec+CG5ZeKt7minIt3HLTdMk4=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=dXTD/rqlF0xsBEccLKG5GrqUT/vXEjP1zuOpAPm7Tp+l9uiauh0jS0PVP/VEr4xMIZ
         umBgcvgPncJBmj/ypdO2utsdyBeCUK+AEzZNU/PDKncxIOOPqCS3u42DYzpDBU1ScirO
         81jR8BuLwVyG+Y+Yzl5jvJzs2LKNdUNI06E/EkLM/r7crJkHErUlPdbVaIUATI3TJh6R
         qQa2eYepIHK52CnW86v4Yv2BPRGlFMo8TguVq3ooTj14XFbxqg3ta7z4Un3VksdCBnn0
         wwJJBeAvIJcyoCBoA41/G+3X76Qt902S1HSM9aTb6NUEMcX8FoXT69a5RtUSxQfOlj1L
         09sQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774000281; x=1774605081; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UDJZUpTuhl2PI7c5/ENec+CG5ZeKt7minIt3HLTdMk4=;
        b=PJmINckeiu9NA5gWB1OJdo6CZfIWRehLffaW25tbT2/rnD8clGc9Y8yVORO1/bvaAt
         kCyoKIvoQtcNiuOCnKLXUk/QV4Imodlykkq5c3iV8+PBYZxuazFSxmZs06v1bdpH3uqn
         aIesQkbS8iRoKMq+KjycEyfqA9k/clKdQFBJkM75r3e3UBEOdQGsV0f58xbJ7GA6sz6O
         KatdXD1xhzz/jnHN3Y3xBemX22dgheDklra4EU6ojESUFeTCq2pzrk7uANrbCNq35COJ
         YVBeu40eWRiGU8y+omApWzxtxdmFio49JKLOt8qJpcNM08s1KuXBJZ7RK8WpAwCDTnbs
         mFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774000281; x=1774605081;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDJZUpTuhl2PI7c5/ENec+CG5ZeKt7minIt3HLTdMk4=;
        b=FrVIp8hinV5HdJyMVEd2lRmzHn1Wfamtc4ZoEalhiyXp4ONQjvabQmVTTER0J3b/Qg
         su7uncDbExwak3V+4dF+FcntGsK6PM0i08rZVG3JOkaMOR9eFML21RYHtS4PvfL2xXf4
         gRxnmNoy4ji4cV93bCdRo47ZDXGi5OmSZDeT8ixVIQZOEVthFalJIRXKIPopYpjqtuPv
         y3CG1l9KPYTrNhHd8qSlLb7ynGN0i2sjja/aokHHCopHMh3EyINux1K4s343CvnOg/le
         aCfRtMIU3MC6tzapOjRMcIGi/N3mkBdy00JoePqOzAJijbN8B0uc8grct2GvTdyXPzEG
         1VMg==
X-Gm-Message-State: AOJu0Yy8pKrcZd4l2iIBKzd0YRs+y72MaM28/bnB//LXuUoZfj9qNURq
	pCrEUGC++0NXsH95HzmY/ZEphrA0aagMsAb2oDK4fM/vJoHjDrz8bsYadeFGlqoFIuo3NM1HI65
	J47ziXSNNuj3wEcRBf5pqY2afqi1DxZRiEp6InLOljg==
X-Gm-Gg: ATEYQzxDE8HYfWUtR03W4hV/Z/MJXrQ80ZXWIHAT0Heazy3k+QDCw2ULEODh0Fs3Q9b
	iYL4AxMErENj/cNBdlKAaS5yhqoqDsjrSu3/ROtX5gWVNOgfzS8bNtLL9mstZwZHofFQC4TER+p
	Gn/JY8VACZRQnMMjvxN0eUthboVhtFrMhNtLR8Raon7bgqujjniONTOlpxoZ/jLDuMl9RRtpOdU
	7C0dOBCTu50U4/iM0Im+zTTy/bQ3GUjSEqYrS8Q+nMlzfnQfHyGkZwE/3MdwzTM9mbOcehvmNiM
	hahvaN1bWr+r
X-Received: by 2002:a17:906:88f:b0:b97:eae9:d45e with SMTP id
 a640c23a62f3a-b982f398aacmr139456166b.50.1774000280759; Fri, 20 Mar 2026
 02:51:20 -0700 (PDT)
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
From: Kamran Alam <kamranalam4555@gmail.com>
Date: Fri, 20 Mar 2026 14:51:09 +0500
X-Gm-Features: AaiRm53mTs-IkbFZx71K-dlITQouFu8O_QsWJQDU78NzH89yS_i0OkmT7T-rg-8
Message-ID: <CAF7tac6s+4eAuyR7tEWMRTPVLBULnV6=7W1bDbgRvK51VWRfDg@mail.gmail.com>
Subject: =?UTF-8?Q?GSoC_2026_=E2=80=94_Interest_in_Fuzzing_=26_Image_Injection_?=
	=?UTF-8?Q?Project?=
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="00000000000090f22e064d71a0bb"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	INTRODUCTION(2.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2879-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kamranalam4555@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: B60942D84B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000090f22e064d71a0bb
Content-Type: text/plain; charset="UTF-8"

Hi Gao Xiang,

My name is Kamran Alam, a third year Sroftware Engineering student
interested in
the "Advanced Fuzzing and Image Injection" project for GSoC 2026.

My background
i) Research paper on page replacement algorithm simulation
  (FIFO, LIFO, Optimal) across filesystem, video, and browser
  systems measuring page fault rates systematically
ii) Python and JavaScript experience
iii) Currently working on Issue #22 (GitHub Actions release workflow)
  in erofs-utils

I plan to implement the fuzzing tool using Go (go-erofs) as
my primary language.

Could you guide me on:
1. Which Go repositories should I study first?
2. Are there any existing fuzzing tests I can reference?

Thank you,
Kamran Alam

--00000000000090f22e064d71a0bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Gao Xiang,<br><br>My name is Kamran Alam, a third year =
Sroftware Engineering student interested in <br>the &quot;Advanced Fuzzing =
and Image Injection&quot; project for GSoC 2026.<br><br>My background<br>i)=
 Research paper on page replacement algorithm simulation <br>=C2=A0 (FIFO, =
LIFO, Optimal) across filesystem, video, and browser <br>=C2=A0 systems mea=
suring page fault rates systematically<br>ii) Python and JavaScript experie=
nce<br>iii) Currently working on Issue #22 (GitHub Actions release workflow=
)<br>=C2=A0 in erofs-utils<br><br>I plan to implement the fuzzing tool usin=
g Go (go-erofs) as <br>my primary language. <br><br>Could you guide me on:<=
br>1. Which Go repositories should I study first?<br>2. Are there any exist=
ing fuzzing tests I can reference?<br><br>Thank you,<br>Kamran Alam</div>

--00000000000090f22e064d71a0bb--

