Return-Path: <linux-erofs+bounces-2443-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAMBNrfjoWmUwwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2443-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Feb 2026 19:34:31 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50351BC03B
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Feb 2026 19:34:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMxnC1gmLz2xMt;
	Sat, 28 Feb 2026 05:34:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::234" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772217263;
	cv=pass; b=OAamvQu1WJNODJ5+ckigRMohAISxsLmoZkNIeMZE9RQlgTQO1CwT5Jfp0vSONgDfJk5p8YTOCNWwTOwbcElsxH/DDw7gYWsrlhRKhtrUibwF5vMbAJjwgP1UrdAjloBm6cYAN+jST8H141ZA/p6urqm97T30aPtZwdNRzfUSqKtwFlfPnKBg3sj+q7uNlCuyhTY5NWEoGFqKxnfrxS+iwwERsdsFDM4joKysST99knrIXGdOROIRupZe+cpXut+/TMDbt0HZLOB5UgD+ABrwh52NAbQkDXY2A8lkIBkcPA3/R7KZFMfuZsU0OL8FGc3EYc12cV5nSOjqfSoYiQdp3w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772217263; c=relaxed/relaxed;
	bh=NLYJeyx06TgTb/vviakbRTLfbrxm5vsme+qUKitvM84=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ah0f0UGnXf8wNMY8aWGzGNRGTbqCZuo7x0m8n2xNtMbeVtQhwsj1Qa/UNEXa+TM3sY98IFhkOjpTS6MoLXnt0YewuywIMR6NIb/iPAGs6YKY6aDXPiREImj8ZBzqQJsRyBYoGy7GDglCFxuAsuzwbcEJV7gUtIrMu6TEJdhQI7PqzoTCnLDQzH0dLKKaqMuPOdjnapwD/xzC9zrA+3O4eaiE5FUHkLv8P09BbIlgthDeunzePdZ+kAJdK3g/to5huJ7J9XNP+SUzW0uUVH0LxiZgxNebQlMxxG0usF4QsGMdTlsoLdFGKx5dKbU9jJ9Boq/2nArPxgaoAEkMv9G8ZQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DTlHdhSu; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::234; helo=mail-lj1-x234.google.com; envelope-from=aayushmaan.chakraborty@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DTlHdhSu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::234; helo=mail-lj1-x234.google.com; envelope-from=aayushmaan.chakraborty@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMxnB1GBcz2xKh
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 Feb 2026 05:34:21 +1100 (AEDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-389e139ee5eso29838261fa.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 27 Feb 2026 10:34:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772217258; cv=none;
        d=google.com; s=arc-20240605;
        b=Eep+PcKrByMS64JLRI/2h1JwHmtkdd2h2kNSPmnQPX2pTmz3KTLe5kVCq+dyqL2h35
         5HjekEUM9Mgj4OqD9m6/IkByWNp3VnRVSa/Cem4orMZqYhMCsbjAtQ8sXn8GrskkbjDB
         +X/7rXqqRLXV1wKgl8hteWO2FEiuGrXJ0vIqwV/3Vlh8YATsUSDKoCKZ1Ji42AK6JshG
         A2Hq26AW7EruqJ33WOQFLcBumahic2PA/DDOJHSVUPMcweJ3lMhS4QNQey3Rt5sQ5EXi
         3YNifjIdwcZb/EhfSDVqhoz+cLusag9eiQEWXZYyzTU/PUXE1XZHdYx8KJshstO6TujV
         872w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=NLYJeyx06TgTb/vviakbRTLfbrxm5vsme+qUKitvM84=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=EZ7djsaHUlKXy8ENd9XxQZm3LLcrtJ+ZqZFgLpGTmfw411DZDSp0vbWGLxelRBjd+n
         MMWHfYAygxY9f8fKY4zqk7mgk5fMf+Y4Dho6xHHrkXc4V8/VR9KqME18hfziFiqnXnep
         epB/NnYKtMfF2WFIwZZGgIIPeSaGmVijEi4gLcr8W7TJJxFs0GZOoKidrpG+KUpobI4T
         uEpD3niPbnsrchz8d4MwiAGdb+wqW19VXg3zJjkmAM8N/ro4Y1BXQxhVlBQZg+Qothbh
         26P9Ey/jdI5MeVw2OqJCNd2o6v8b5rC0kwOR1nts+/u8Li2ttsP1AclCg86VwvLlVBNK
         CaMw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772217258; x=1772822058; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NLYJeyx06TgTb/vviakbRTLfbrxm5vsme+qUKitvM84=;
        b=DTlHdhSul7iV4BGyfst3IOUWknfaDdS2M9JoVDJEqSFi/nXuoERKXYJSwj2aWITLNr
         m+CcRcSiRo9+rvrxDiZ/H6Zt5mW+O+obFe4rZJHMixFF9hHD5Ehho9oqg9Y3cbq88a+A
         rhP63tKLt35z5bPCup6RAir5ZtVNcj8Lfn8p53kCapRpT6xHuBuWGVC9sDXRMnPsHrnG
         SQZxNpYn6piD087Ei2BcK2cgvQVruwqRtVPRheXW3K3JjW+ZJl1HBQ4tBp+VOOJ8g3Kr
         S9McUPQsPdX6rutTAG3ya5xAm4SMRZldbc08w6pS0bTZSddVIFzUvkUWqMJL+NVaey9C
         Orpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772217258; x=1772822058;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLYJeyx06TgTb/vviakbRTLfbrxm5vsme+qUKitvM84=;
        b=q6tOQnCjm9IM28FqUV2l14r2SKHPvQdPzXTOi+DtSmdrrj5GG83K3/3J1MZj4VQ2je
         SpSrxHW4MsqVRHnUWe60rt7aD+lndeZTbTptyKFhgE/iofkbv9Gfe5nbNTgU5RHYx7Tj
         kHaMp0PbDn8Xu+AK01gPliab+pkig0wXoEvwG5n03GGCjh37kwsW050HJ8x9zbLx1quo
         vCtoftcTIUjhnb9qNNOxuw0QCGxzfAMT5l0Mbq0W8C5izYPTm7AY1N/ovMGqB+ALSq92
         OPoOYMiWozl6PG3OA7LCHdMYOqoaJNDkoZrA52xhTI9zSLMLw1HPxGTfvBklGWin/aAM
         ognQ==
X-Gm-Message-State: AOJu0YxGE7jQdhuxPaprVHxbK7ryA+Gb3AD41q0pBtTtiPmnKlGPkyPh
	h1DLPzyesy6cNY4n+baLFQrxsa0bO3i4Gt/CsskTBeshzVS5PoOMqe6XDzP7g1ecRUm66Avhtv9
	l6jTU0b/EsqqMagnLGtYaHof8MtvfsE1fqmRch40=
X-Gm-Gg: ATEYQzzAbQB16W95FtcSyG1BCRn8e0NuusCwurCQ+cNQS87fnnH+Jt0tHsFCfl+5NXd
	IDFEtHqIIP7yPTCSX+wEnrGT5Qz0sMRAUKTGvtuTOEFimYKB++OTDlFQkImY9HH1aNIl1OHTWfX
	qypbqaAfi0HhqNWeVDGNxrzpRpbKfex7V1ukcmIOd5KZisLywajOeReqN7aM1Rof6d0RWJKDOoa
	f8ilv1QVCXRdyhzO02Seb70ZfqyFNb9YOljNpRGHLS6o5XwGX1skoTftf3M2AmHfAWHuRO7KIyA
	UKQstis=
X-Received: by 2002:a2e:a992:0:b0:385:b735:4fa0 with SMTP id
 38308e7fff4ca-389ff1169b3mr24981061fa.7.1772217257728; Fri, 27 Feb 2026
 10:34:17 -0800 (PST)
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
From: Aayushmaan Chakraborty <aayushmaan.chakraborty@gmail.com>
Date: Sat, 28 Feb 2026 00:04:05 +0530
X-Gm-Features: AaiRm52ktBr1ir5AZ14JXQJ-5ktS_-0zi0vCQEOlVlHgpcpSmgANlYYCMmKtxFk
Message-ID: <CABCXVcmpxpXhrUmD__UDtLe3yGvO+wyWYDLqY4nia_WhTZ80mQ@mail.gmail.com>
Subject: [GSoC 2026] Prospective contributor interested in EROFS
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="0000000000001ca478064bd27cc1"
X-Spam-Status: No, score=0.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FROM,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.20 / 15.00];
	INTRODUCTION(2.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2443-lists,linux-erofs=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[aayushmaanchakraborty@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: E50351BC03B
X-Rspamd-Action: no action

--0000000000001ca478064bd27cc1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi linux-erofs community,

My name is Aayushmaan, a CS undergrad student from India. I'm excited that
EROFS is participating in GSoC 2026 as a mentoring
organization=E2=80=94congratulations!

I'm drawn to low-level kernel/filesystem development and would love to
contribute. I've been exploring the project:
- Kernel code: fs/erofs in mainline Linux
- Userspace tools: erofs-utils (mkfs.erofs, fsck.erofs, etc.)

I'm setting up a build environment on my Debian-based system and plan to
compile/test soon. From the GSoC org profile (and any published ideas), I'm
interested in areas like compression improvements, fsck enhancements, or
multi-threading work=E2=80=94happy to focus on whatever mentors recommend f=
or
applicants.

Are there any specific beginner tasks, setup tips, or preferred GSoC
project directions right now? I'd appreciate any guidance on getting
started or small contributions I can tackle first.

Looking forward to your feedback and hopefully working together!

Best regards,
Aayushmaan
MyGithub - Aayushmaan-24
[Optional: Mention you're on a Chromebook/Crostini if relevant later]

--0000000000001ca478064bd27cc1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:trebuche=
t ms,sans-serif">Hi linux-erofs community,<br><br>My name is Aayushmaan, a =
CS undergrad student from India. I&#39;m excited that EROFS is participatin=
g in GSoC 2026 as a mentoring organization=E2=80=94congratulations!<br><br>=
I&#39;m drawn to low-level kernel/filesystem development and would love to =
contribute. I&#39;ve been exploring the project:<br>- Kernel code: fs/erofs=
 in mainline Linux<br>- Userspace tools: erofs-utils (mkfs.erofs, fsck.erof=
s, etc.)<br><br>I&#39;m setting up a build environment on my Debian-based s=
ystem and plan to compile/test soon. From the GSoC org profile (and any pub=
lished ideas), I&#39;m interested in areas like compression improvements, f=
sck enhancements, or multi-threading work=E2=80=94happy to focus on whateve=
r mentors recommend for applicants.<br><br>Are there any specific beginner =
tasks, setup tips, or preferred GSoC project directions right now? I&#39;d =
appreciate any guidance on getting started or small contributions I can tac=
kle first.<br><br>Looking forward to your feedback and hopefully working to=
gether!<br><br>Best regards,<br>Aayushmaan<br>MyGithub - Aayushmaan-24<br>[=
Optional: Mention you&#39;re on a Chromebook/Crostini if relevant later]</d=
iv></div>

--0000000000001ca478064bd27cc1--

