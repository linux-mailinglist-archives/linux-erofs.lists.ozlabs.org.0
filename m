Return-Path: <linux-erofs+bounces-3143-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEcjHKvMy2luLwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3143-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 15:31:23 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FE136A4AE
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 15:31:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flTXf4BDWz2ybR;
	Wed, 01 Apr 2026 00:31:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b133" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774963874;
	cv=pass; b=KqLYJJCUlOLx/ZZsPUB6An8711nSdhzHRi0URiweuSLmHavQe9XVCnpDPiMYg4lf3p23HMCCs88J9wJajAeUyPeHPG89u01rZD/w9uzNYkByRKtI1ZFaLYlQ5VUu1W/kTfdgxfH/DUGn91l3OtZRLBfMODOx0SoL91Zls8wVeMryn+2J7xXAYHIBkxKOJwqyXP+qASJ1Hu2QEeTc1t0lif2oMZ+OwJ+HwpBMilSwnaAw42TiCeUBlui6O34rYWv4SUWas4yPJeM4yFrcdYRg0il628gPFeuhIDTUaA/kHlqAjheZDf+jeCV0sRS7KUsw9RL/aaRkXokY+JVRYgiqYg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774963874; c=relaxed/relaxed;
	bh=Y9G0n9zcBLS84pU9eGTEhiXbEoFoe7k2PhFBybNBl0E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jPXdlF7lNDYmA8WJhkiXt+mSeCuOw000bwXV76qhUAdUvylYIWhXSsPQRy95rbIMnHzvWP/jIE0htk1bj4d9w3u0COQJhyUK5NwOHcx43W1qCZOhE7A6NDHRSSnoYcnusjuw8CgleA6TQOgYKFqB6loyaePbgkLGNKYYAa/a4jVFbhqwWcC2v0WeYRH0grBADRtaVPrv+Q+ZHSpHcDifyvtCPALMqClvz4TFElJhCJR7aU9Htecwefn0tIRglQmF+fEBuqR8im/jLXLYxBq2bpDFaqmDDQFpAHMhN1O6OVyn4iMByI83COaq2ASVxBFb/fkEKBa19ugxufmu/oL+qQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U7eYP8MW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com; envelope-from=priyena.programming@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U7eYP8MW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com; envelope-from=priyena.programming@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com [IPv6:2607:f8b0:4864:20::b133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flTXc5L8sz2ybQ
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 00:31:11 +1100 (AEDT)
Received: by mail-yx1-xb133.google.com with SMTP id 956f58d0204a3-6501d32b04bso4371311d50.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 06:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774963869; cv=none;
        d=google.com; s=arc-20240605;
        b=eEJveZXmoSd0NwrraIACxKQvNzNkxEdXMClMkiKQj9I6ZT5xpIsHS9zVTY3wsQkdH9
         mxTHG4da8L9ctfEulHHhx+zHzU5pmvvsX4AJw8EpwBEjUqbYvepeg4eerLz9IxgEkLxF
         Hcs9uQttcVVyczXuvWafj1Dj+4o127AYZC2xHOPNSy6MWfZrbWusImDLpUF4f2gN/OM5
         CHyd0c3WKZZIv6PbfZ1aP3vmsOsWhZq+exomLYk9/OmDtMbFTYOGnkZc1Mq3Du1Z1DdX
         xUyNNXSswww1QzrU7AYFgoyId35MDz8B9Ic74JJ4aNogAq5qP1j7SAq7YvLhCqOi9ngE
         oMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Y9G0n9zcBLS84pU9eGTEhiXbEoFoe7k2PhFBybNBl0E=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=Ajt4U2YlQ1sCvRwW+KQhzWztIWwYAI9vUyBv3hkFX/CvxpUbrm88lAWbakl0RDIkmb
         WQkq411U4mDDOxWcVR8yISNWtVT1T+QIvsh1ugPdNtDaCVkAyWnNG8yrhvX98TNb3rUE
         cB39mZ1ZoI3Qt2mlmNPpRGK2RlLqh4Rg+OdFhpnzP/d7Hf/DISbbgt2A2XS5DfgDf5UF
         Pf7WNXDFeb8IOcacRQ9pvgvmDXq5r/SLRQur4+Te6/5930nUKPXRwgaSVi2eJmmc4EbE
         nrBmRjU1cYKqDEKHoxX6UNilGMSmT6e9Uj+0eKtigGk/gyZM55iNM4MuOZ5sKADjkUn7
         9+iw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774963869; x=1775568669; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y9G0n9zcBLS84pU9eGTEhiXbEoFoe7k2PhFBybNBl0E=;
        b=U7eYP8MWSztnQSLeuG8DVwjmmq9w4AAGiwj7OilGXiKLC47vVaHBM9XFsf0esG/6pg
         sUyjR/MZ2bq7G0hszaZ2sJZ++qzutwhV4+keHihGQ2Qj9Lgqsna2vhryQJ6BmBfxNAcm
         MFgML9OiILfkPtWydcQcFNFkHTlSSpdT+vrhP6kzgZJlT/Q99pm1RUPJ0YOFXT7AEoly
         2uLrORZqXzq678cZjwyTofATQ6ikAD5EX/3eYtTP6PJDPmgCq3BpCZAl1tkkQpbo/I1/
         hymmjl1hexo0j9Zfsp/KsqIBxVvN3q8iMB84BQ2OrhifeHlPHEG/EgaAwd1+dm9jGvxW
         OTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774963869; x=1775568669;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9G0n9zcBLS84pU9eGTEhiXbEoFoe7k2PhFBybNBl0E=;
        b=eM/n+j88sjPD0wVzo22Zzr0tAycsonQ7qoNwj95zhdAKZMKCTJhCGezNE2v6TXW1hP
         jnPY94Y5Nn0ASLHrle1yKB15Y21MJO/602bbcWG53m424VlgtSkpqNauP9xDA5Aceycg
         FhtgVah4kA6vOkYbGiJbRYhK9EEPPwUUTv7La351onn2iy0dYi96Au2NkB3EGJK21HV2
         4HfDZI+nJSehaRsudmdOhCPBxwOwjuyI0fUpPSL4nE5ibw0/IuPjErAp4p0NCNcPtRhA
         zlbjbTBp6JF0fo0g6Uue/taJbikNSFPMC37PP0lpLPbEL1eXHbgCo+eUGQsQ6m4PPuLP
         a33w==
X-Gm-Message-State: AOJu0YxHawbzUCVZmmos5v064WhkGDA/KJvusIPyKIMHvP39rkOm2vqW
	n4brkRcDFeDgpPBeORZ1e2B69QqmY471+GuTX9Ong/NReXfVObK8F/PM7RCAQIlR8A/APWBxc+a
	S31W0j9pZXuC6wRv88lQF7EbNPw279WlVEjFytW3YbQ==
X-Gm-Gg: ATEYQzyScby+dFZFuzWKjIjvaCvW/jVbo338cXa937yflfD3rNAV8rYKzhlSoZJQhtf
	8gTtAzHHbKMbuoQkQj6T3fkn1GRgObn22L6ZQzQ5JVx6upgEprX5wxP+YNNpPXaBWFw3VYuvTKp
	iX7Tw8tU/XKACz60ceFJ0IlX+uEUh5w3dh1dSiYNja5PcM5/QucZI6welvVn36PzIS4zXCT5HlX
	rNH4Z2+FcfL/qcjbbHDvStfc4gFOOKZV8XBNzVtnvsPMkkHp2MBcOzokWqPbeccoSlM1iXIiI1E
	X4MF6w==
X-Received: by 2002:a05:690e:488a:b0:649:cf3f:b318 with SMTP id
 956f58d0204a3-64ff7403e61mr11374824d50.54.1774963868631; Tue, 31 Mar 2026
 06:31:08 -0700 (PDT)
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
From: Priyansh Saxena <priyena.programming@gmail.com>
Date: Tue, 31 Mar 2026 19:01:00 +0530
X-Gm-Features: AQROBzBPD6ww45bvHyi79wv3KtMFUYYtCuzoCRGf9idnz-rRJGN0JbaDHBvtc1U
Message-ID: <CAPXyYWf=J5iyZS=ZRtC-mOePzcc-nq-i7P6wQuw2tqDAr9+obw@mail.gmail.com>
Subject: [GSoC 2026] erofs-rs xattr POC + xattr_size() fix
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000e10aab064e51fabc"
X-Spam-Status: No, score=1.5 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
	autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3143-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[priyenaprogramming@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 77FE136A4AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000e10aab064e51fabc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I=E2=80=99m Priyansh, a student at IIITM Gwalior. I am applying for the ero=
fs-rs
GSoC project. I have been reading the code for a few weeks.

I found a small issue in types.rs in the function xattr_size().

(count - 1) * size_of::<XattrEntry>() + size_of::<XattrHeader>()

when count =3D 1, it returns only 12, which is just the header size but
there is also one inline entry after the header, and it is not
counted.

In line 115 on filesystem.rs, this value is used to find where the inline
file data starts. Because of this any FlatInline inode with exactly one
xattr gives wrong file data. There is no error or panic, but the output is
wrong.

While working on this, I also built a working inline xattr parser on a real
test image:
https://github.com/priyansh-saxena1/erofs-rs/tree/xattr-poc

I will send a patch soon to fix xattr_size().

I have also submitted my GSoC proposal.

Thanks,
Priyansh Saxena
https://github.com/priyansh-saxena1

--000000000000e10aab064e51fabc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi,</p>
<p>I=E2=80=99m Priyansh, a student at IIITM Gwalior. I am applying for the =
erofs-rs GSoC project. I have been reading the code for a few weeks.</p>
<p>I found a small issue in <code>types.rs</code> in the function <code>xat=
tr_size()</code>.</p><p><font face=3D"monospace">(count - 1) * size_of::&lt=
;XattrEntry&gt;() + size_of::&lt;XattrHeader&gt;()</font></p>
<pre class=3D"gmail-overflow-visible! gmail-px-0!"><div class=3D"gmail-rela=
tive gmail-w-full gmail-mt-4 gmail-mb-1"><div class=3D"gmail-"><div class=
=3D"gmail-relative"><div class=3D"gmail-h-full gmail-min-h-0 gmail-min-w-0"=
><div class=3D"gmail-h-full gmail-min-h-0 gmail-min-w-0"><div class=3D"gmai=
l-border gmail-border-token-border-light gmail-border-radius-3xl gmail-corn=
er-superellipse/1.1 gmail-rounded-3xl"><div class=3D"gmail-h-full gmail-w-f=
ull gmail-border-radius-3xl gmail-bg-token-bg-elevated-secondary gmail-corn=
er-superellipse/1.1 gmail-overflow-clip gmail-rounded-3xl gmail-lxnfua_clip=
PathFallback"><div class=3D"gmail-pointer-events-none gmail-absolute end-1.=
5 gmail-top-1 gmail-z-2 gmail-md:end-2 gmail-md:top-1"></div><div class=3D"=
gmail-w-full gmail-overflow-x-hidden gmail-overflow-y-auto gmail-pe-11 gmai=
l-pt-3"><div class=3D"gmail-relative gmail-z-0 gmail-flex gmail-max-w-full"=
><div id=3D"gmail-code-block-viewer" dir=3D"ltr" class=3D"gmail-q9tKkq_view=
er gmail-cm-editor gmail-z-10 gmail-light:cm-light gmail-dark:cm-light gmai=
l-flex gmail-h-full gmail-w-full gmail-flex-col gmail-items-stretch gmail-=
=CD=BCk gmail-=CD=BCy"><div class=3D"gmail-cm-scroller"><div class=3D"gmail=
-cm-content gmail-q9tKkq_readonly"><span style=3D"font-family:Arial,Helveti=
ca,sans-serif">when </span><code>count =3D 1</code><span style=3D"font-fami=
ly:Arial,Helvetica,sans-serif">, it returns only 12, which is just the head=
er size but there is also one inline entry after the header, and it is not =
counted.</span></div></div></div></div></div></div></div></div></div></div>=
</div></div></pre>
<p>In line 115 on=C2=A0<code>filesystem.rs</code>, this value is used to fi=
nd where the inline file data starts. Because of this any FlatInline inode =
with exactly one xattr gives wrong file data. There is no error or panic, b=
ut the output is wrong.</p>
<p>While working on this, I also built a working inline xattr parser on a r=
eal test image:<br>
<a rel=3D"noopener" class=3D"gmail-decorated-link" href=3D"https://github.c=
om/priyansh-saxena1/erofs-rs/tree/xattr-poc">https://github.com/priyansh-sa=
xena1/erofs-rs/tree/xattr-poc<span aria-hidden=3D"true" class=3D"gmail-ms-0=
.5 gmail-inline-block gmail-align-middle gmail-leading-none"></span></a></p=
>
<p>I will send a patch soon to fix <code>xattr_size()</code>.</p>
<p>I have also submitted my GSoC proposal.</p>
<p>Thanks,<br>
Priyansh Saxena<br>
<a rel=3D"noopener" class=3D"gmail-decorated-link" href=3D"https://github.c=
om/priyansh-saxena1">https://github.com/priyansh-saxena1</a></p></div>

--000000000000e10aab064e51fabc--

