Return-Path: <linux-erofs+bounces-2717-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Acm+Do+Qt2kKTAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2717-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 06:09:35 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5077294B54
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 06:09:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ36g1cs9z2xln;
	Mon, 16 Mar 2026 16:09:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2001:4860:4864:20::2f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773637771;
	cv=pass; b=PKZ68jDb0kqG+V4X1sfVbozFTh2U5vAfSzG9ZHa7DrGpQCoj+xWmMgyg+4jmJc5LDAiKvT9yPAIOaxwjyAjuSC7uyUJ2QKpm50BYA6Cee1+OYfNEc0hLhjLCDPlr/mtsUX79STueRbjG2VxHCowFFW4lahgz1Qeb3Q9lHfquc1ohRP/7oSfQ+mqjUMylxQ9Pkz8hvbQo0BZn4KxmpEp7yY5t1BPucN8C1tQFhYwA/2vacLuPVT6b7CNphpdLBqtgjcv39TEZ/yvieQoq7FodlxnXXuimYMgNTH8XpLHwb07rl87f8dPX8fLmh7ogVpezp878upgLbebxw6y0sn9CKQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773637771; c=relaxed/relaxed;
	bh=PHaIAH1FLL1L0JqRV5xyIG4vNAD9oUEQzuHAO/L7shY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DZ/67DRXEo1Ul6mASGvzvImjsImWAt7FK0DC5P5qPkdYGz80fQPTjqVYEZh5PsXpMbF5QRzVr9dVx0mAmrNeJwDO5zmiCGocam6CJOHlibrBXF7ddOkbEjsrYcV/gaPQ0UnkiFAwICxYS6y8+pd1FUHextEAy9uO0NiTJP17GClpkEUIxNXNx4blMM4c9C2bDI5cL7QTO7Vqkc2kPeLQmQa2RQ869cny/I/t++UIDnpqz1wbI2RGNGfC5zzAGlmW6OJqP7yjsmAo3RdOyOTSd0/5JdSSrMZ+PQhumrbXLLUAOzbGbybRfd/Ge+c5ctNkqKV1pLsfMmO32oP/PRmSag==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jsS7OPVE; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com; envelope-from=divyanshkhatri999@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jsS7OPVE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com; envelope-from=divyanshkhatri999@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ36f20z3z2xlP
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 16:09:29 +1100 (AEDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so2479016fac.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 22:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773637765; cv=none;
        d=google.com; s=arc-20240605;
        b=H7iXKz0FNoqMYAFjMHkevaODx6AKAjNyljKaybmGBwmO5ZF/BgOMnlXxuUOeBOJ2bV
         sndidvUynVFjOY5v49nUDd72BEUh18bQVD4stxLKZB0nCwcqj8ORmr2jD8JdpDzzfDtI
         tA2lAdB8wsapaIuvwZaf+8Ul/5ba00TrDimvTUYR6mSD4jOB9KfIhkn83/xTp2Upvi6F
         xlicRFVlQsvJBDZ+pBzM1ZOiL7EIchi02pO2FFXqqruf84A/j0Pkplmo6pICqkoyhzSv
         73Hq8mtfuKmF0iH+rhdcsGrtM4oPZQKefh+mE5KVIaE74a/L/U2CQs3iwxxyJ8nP7iML
         rGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=PHaIAH1FLL1L0JqRV5xyIG4vNAD9oUEQzuHAO/L7shY=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=e/3gisnW8vjSAaZufbNm9oHGLItMyqjcBmGKKe692F0Adj8IakTOC36h7nokgfByca
         qWlnimBcrn4aT+fuMVKK0h+twpaPk5LYinOHxGljdi3xubDAsjf1qAaI84tkvZNFeopy
         db5WEVzTBqsJWwvTiTB/aXXy3cIbbq9/lm6lMOhyVBkurx1M695YDeoY80njWlyHI1Qi
         wvc0Jho4nwg+OZieGj59jkWHxcYaCI4fG0Dk7XVoZPLelpZeVFXRsBQSvcyUHO2nJjAp
         5ZP5m4M7P3roCnFuJRNIlbUOofa7FnJiFzOlNXTWzBeHRt34cgKJkTPjzFXsNYCtfdOM
         xduA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773637765; x=1774242565; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PHaIAH1FLL1L0JqRV5xyIG4vNAD9oUEQzuHAO/L7shY=;
        b=jsS7OPVE2JCyYVvdKHXjD9IFBMEfzka+UZEUkftDxwhT6j73GK/cS7e2udVpSYAyis
         pOyZNfXJ7i2CQljVa6zcDeJYRVzhvXw50xN6y/v1Sc5/hbhB0dKY/gQAbh/sgi3XBvDh
         uv1PuE8AUaj6WwFCsN2kSgyHhVyRpAxzmA1EsmDjEEgZN/BFOe0x/Flj96DBty1DbJSU
         zmRF+DXmJAGt3QpQt9yIw15Xt1XpN9Jx798rByIR6oDR8LX9I0opx5KPd5cGdlD6t9nh
         9iR6oiHB17k6dokLC1GqW5UL6Kt2PScltvCLR2obM0SE5V3Re9321w2EX7aTxVch9Mjl
         JWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773637765; x=1774242565;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHaIAH1FLL1L0JqRV5xyIG4vNAD9oUEQzuHAO/L7shY=;
        b=PqofBPsYTt5f9fu0TfUvgWCoytbBdAInXoWaS+kns4rZEj1xzAWFH+vHPUFwe2x4AK
         uw21IftS5VudPTulgPkKYzuG2wriUY8YJ2Yv+3G8cxYjAHhwSlC+sMmRVUEzPl9cEZGu
         3lQ8yj9GI2KNYBaSOb91UnDAmjy3Rh6k/oMWwwPNm3caB4Xy5RFSGl/Wh3vV9UvB0YVO
         eXEdQPQrbGfmxXFuOqsHAVos+7UQmGjH6dwAeC5zxJMj9GE8CR9xYzB8FwkvluQLlDr1
         mWnKiH9nQ/jWfWerDp7BsutQSjHiZ9z3LM2gWrhTVvA9oall17DrxVMqNWS08EjUWlq/
         cmQA==
X-Gm-Message-State: AOJu0YxOrVevwkX41Mi+FCjxnAwysDa3oxaHzqE5mA/nJLnrjeQaYTE0
	EuVLpk5Xu0sjQdxzQmMFpPI7SKq6Tq3szVsN0g43mL++exkuNZvInv5+MwphWA43UkZ/+QhNBiP
	akuPJ5PK1vbUE7+YcF8nI+cGdk6yTrj8QukWPCww=
X-Gm-Gg: ATEYQzyBr75xnFzUqZ0QQ+HR3OSYyGI6JEX+9HvAGdYfhtookrQB+E5s+WbdJCD6X/P
	VvpX2IpaIdEFYmtQnHSg+QeqlVAdLCAlhLnSn6ILq4B+1H/a4jSUlUPmx8H14eNfIrWW4/2EPVZ
	VmhUoJP2PLe6sR7h58y6msCIlIgOevjjoC1cNJNREZCr+AWyMw4iEILU1ByQMjejbor4dfUHMpw
	TCFRJnTNej1umSex5eHQvNhcJVjsItJHHx2qepoe17XfrZWsLNBenIrErwmjo+VdSknJaZkXGD+
	Es+ajBRSJSb9xErnde+9zVpX57H4wAS9v1derUYUT+saPMICqw==
X-Received: by 2002:a05:6870:1426:b0:417:2daf:6a9f with SMTP id
 586e51a60fabf-417b9450868mr7634057fac.47.1773637765277; Sun, 15 Mar 2026
 22:09:25 -0700 (PDT)
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
From: Divyansh Khatri <divyanshkhatri999@gmail.com>
Date: Mon, 16 Mar 2026 10:39:14 +0530
X-Gm-Features: AaiRm51sh5mFrpVft3uxDXeqjc5HrKjQS19-c2KpTEE6clQE1a52s4cWOe1cw5c
Message-ID: <CAHXp+FOo+H1QnbcQdGCzffr6YVGtUVptx+D18R3WPMcJzhy0Fw@mail.gmail.com>
Subject: GSoC and Introduction
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000f5aacd064d1d38d4"
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2717-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_SPAM(0.00)[0.203];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[divyanshkhatri999@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E5077294B54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000f5aacd064d1d38d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

My name is Divyansh Khatri, and I=E2=80=99m a final-year engineering studen=
t. I=E2=80=99m
interested in working on three of the EROFS projects for GSoC:

   -

   Multi-threaded Decompression Support in fsck.erofs
   -

   Support generating filesystems from manifests with mkfs.erofs
   -

   Complete filesystem feature support for erofs-rs

I haven=E2=80=99t contributed to EROFS before, but I do have experience wor=
king
with C, C++, WebAssembly, and the MERN stack.

As a recent example of my work, I contributed to CNCF WasmEdge. In that
contribution, I updated the upstream of the Piper dependency because it had
been archived and development had moved elsewhere.
Link: https://github.com/WasmEdge/WasmEdge/pull/4443

I=E2=80=99ve started exploring the codebase and working on my proposals.

I had a couple of questions:

   1.

   Do prior contributions to the codebase impact the selection process?
   2.

   Should questions related to specific projects be posted here, or would
   it be better to contact the respective mentors directly to avoid adding
   noise to the mailing list?

Thank you for your time, and I=E2=80=99m looking forward to learning more a=
nd
contributing.

Best regards,
Divyansh Khatri

--000000000000f5aacd064d1d38d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi everyone,</p><p>My name is Divyansh Khatri, and I=E2=
=80=99m a final-year engineering student. I=E2=80=99m interested in working=
 on three of the EROFS projects for GSoC:</p><ul><li><p>Multi-threaded Deco=
mpression Support in fsck.erofs</p></li><li><p>Support generating filesyste=
ms from manifests with mkfs.erofs</p></li><li><p>Complete filesystem featur=
e support for erofs-rs</p></li></ul><p>I haven=E2=80=99t contributed to ERO=
FS=C2=A0before, but I do have experience working with C, C++, WebAssembly, =
and the MERN stack.</p><p>As a recent example of my work, I contributed to =
CNCF WasmEdge. In that contribution, I updated the upstream of the Piper de=
pendency because it had been archived and development had moved elsewhere.=
=C2=A0<br>Link:=C2=A0<a href=3D"https://github.com/WasmEdge/WasmEdge/pull/4=
443">https://github.com/WasmEdge/WasmEdge/pull/4443</a></p><p>I=E2=80=99ve =
started exploring the codebase and working on my proposals.</p><p>I had a c=
ouple of questions:</p><ol><li><p>Do prior contributions to the codebase im=
pact the selection process?</p></li><li><p>Should questions related to spec=
ific projects be posted here, or would it be better to contact the respecti=
ve mentors directly to avoid adding noise to the mailing list?</p></li></ol=
><p>Thank you for your time, and I=E2=80=99m looking forward to learning mo=
re and contributing.</p><p>Best regards,<br>Divyansh Khatri</p><div></div><=
/div>

--000000000000f5aacd064d1d38d4--

