Return-Path: <linux-erofs+bounces-3722-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dAC/AHidOWqhvgcAu9opvQ
	(envelope-from <linux-erofs+bounces-3722-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 22:39:20 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A64F6B251A
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 22:39:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GqGImVct;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3722-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3722-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=2")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkg6B5YBGz2yVd;
	Tue, 23 Jun 2026 06:39:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782160754;
	cv=pass; b=PhhwU3gFD5VPFJ08NYUcgggHSIhKmaYzZJ8h9NiPytiMQGaDHi/sy06Qlx7mlFhWHU0LBrAPnIEq3T4kX+taywjMB01YpT+y9XCybAAByniMLqURvh6oPLp5emvpjd7I8dar6TdAwW4VqGhwJSqYhEVLgML0zY9jT/nIIZp3l56nUhae7itP7I8yj8DEKwWBOL/fNMmqJ7W04X+T0Ym2IPpLYszVxuseIx+NaJIsgnqn2KUtM7e7JHPxHBul+g5SR/+DOY+76npdAkQgzgQy1FDKD/bANJF27K2aCjivdeX8LVVNmUjKIsSgxbMdMi1M3YzN7y1L5jA0wolXXGl/sg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782160754; c=relaxed/relaxed;
	bh=hwWevhyM7Y8HuBXJW/1xbZr1aADQu/Ufs5F1snkP+x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dO4TDRcIXnI1KPYIcOcXCoY+cOOu0erSBgIjqXe2T1bHKBw/YKdzXvT9B2vzflDnahMsHF/RJEb4Fdxbrmvsp08IxfXzvpzMr/fEvY0w7CJmVNKya/aAFSCon1RGWgUTrw0fkoQO/JBJi0m8E5bXaDoHjnoRhz5FuxLWTNfDlDOMm1f2bUVzgmqhrzfFIl10AJ2V6x4ug2nfiFU+6Oxkl6s6FFq6rHZMIVvthaFpEkKJTYSRMA/cZLFnwolfb9ZmM68tuZMRebejLVRgXZ7NkPB27xZvLqlUIB9DcyEUyG57Fc0K03+GV9dFx7ovYERa2iw2NT8tNojIjZ26lSJryw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GqGImVct; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f33; helo=mail-qv1-xf33.google.com; envelope-from=tristan.madani@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkg686jtMz2yVZ
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 06:39:12 +1000 (AEST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-8df9393e4d5so26865446d6.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 13:39:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782160749; cv=none;
        d=google.com; s=arc-20240605;
        b=le2wVLRpyzVUeycTkf42FrkS0XThPFS7buL+Uw2Sj0uMER7zLGdS1TBItXhrLM3BFt
         OGNp/qSQiHEiheKIXSTWqcUSLQ9VwdllVB72mvY16ZOMtLVLJWt4/5/JjY792TendVAT
         3gUzTf8EKrICBk6XSCLerxXzhXnEgYM/txJ/JtOX/jwfpqyfCxRP6LQc4hj7wDkcf9yk
         Fns82WkNAnob4CLex2BdhQ+ShOvdL125+QC/XcPqOwh2V/1cu7lW7DVXte5zMBXxJtbv
         /v3IFvicegWB+qs62yLpkURGUvw0VrEPTW4o4Jc/TRDzJtC9nE6me2pnIjOUILIZNN+A
         s7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hwWevhyM7Y8HuBXJW/1xbZr1aADQu/Ufs5F1snkP+x0=;
        fh=WJhIciIiNZdDmLC1ZQ8ngNos9wKcoX5v3UjHHDA3Xes=;
        b=DwdurXPFmGoTlRCM7AnI55CTZoajnMFf+N648NyNdkHWaklZ6TR7y3eTDtt58NLaFR
         xvsOtOWxF7cUgIGkEPb2i0yPFlDs/Mn7S9hiuR9SH5ozTFirMOUP+2LiwB9UhyWQ+ZTu
         9HNQjEQBcxguoNzoshIkEbp1sSH9Uh2XftHrIaDX20c60JJGV0Iq0ZF5XgG+zXs6YUGX
         oq5o42rEfgkArmRIvf+oiZAI9M2zAfVPkEu5rtMa1UfpLPX1fPNCx19iPbOC4WI83HmA
         b9Uln+oiLI1dlBYIdyDfF2hDDUxSF3vyBLtOeucCOedHcSBez3cSvuhWlMIicdDNkFKU
         P+VA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782160749; x=1782765549; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hwWevhyM7Y8HuBXJW/1xbZr1aADQu/Ufs5F1snkP+x0=;
        b=GqGImVctdgtsRhiDBPCFwvDql5VxGiUd7NrtZN7VFdNwElZbGwRLoX/N3eCvHp7f6D
         DeAorOC+UE0czfqdOxDjjw5tuZY91x7nZVt3wIvCtYyOSLVGsbJKR7w1Uxii7bluqXSg
         PKuQf7MHlAMAwuXGYvopkthsmbVH42TGlmuE4VYyEsFsEobVkFymIJZf3FAw55+cSr5F
         V/6YVyzqNzB+azKmCgu2qgXLEnjSAJkIUObEnfnysP51QdBO4hyId4E/D1uL50l7L6xI
         ikMC1+BABMH9vA0TGWDxy/vYXCk5wzm21U8BC1PAaE3ZatiQzOV1mOdqMPy9jZkGwo2p
         i6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782160749; x=1782765549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwWevhyM7Y8HuBXJW/1xbZr1aADQu/Ufs5F1snkP+x0=;
        b=rUn5u+VQsDRJh0srPZGSUzQyxIkCH+D3njNuBv6NqV3Y8jEYpt3hMls8szVVd3WV6j
         czEbSroV3G88CXyyXYvnMuqdWnOGmgXkJFl+lIMOWhynxAr78XRSeOvntVdmiSxc4o1y
         CI0uQObgju8HR8be15kalE18Jtc1OR7M7BjytnskFpykG0cfc7Vwi4mhv3O/viVW9Kgu
         qCY9hvLdnizCGa4hba5iN4qTC0sn9Jq2dlybXJa1mfrLdSG1BS1mmrt2I4KTkDUHMezj
         gNiuGeHoNcsyK0KgZlumZl2pxzoCdk41QlwbSPg77oKq32uYEvsYgNC/Dz8eB7aZT20U
         5xxw==
X-Gm-Message-State: AOJu0YwsLzn+42nAFErDNcMg5QpmwxNNt6LcAoAckXZv9u9kFRFHWoFM
	JiQSiSxir2v7Q4+r995Vih/el8dGHegx+D9dFGAWn5Uou3rc2mofIGwSzFppQs4P56b5iYbo16B
	wanzTTOHn2+kMINxUdwBQUk/ulMiycaqneqsvMvM=
X-Gm-Gg: AfdE7cmMdnVPI83fJWrRGhBB0NESUoCxKmSZjyusk9PRzEU1g6vr+dAjJyDDuzegbBx
	aC9+9pb26BsVlrUojs0Pus6Nf5YHX1U2xhaEURWQMFactlxt++x0CbtmMnPJoWrDBiP/y9DYPDa
	29tDErz4/m6GQHdXz44zxdkkall1n1+HX4o0Wuq8QvQC+FEwRosb0SdtA/Vxz1uzZCBueppXJzw
	QoquMcKiHYLJ7/a6w++ZOeWEv19earQQ8MA+gadV7CCDLOl4o5/nyCVtzQtdmgB3lRGWO2F+aFh
	IlmCJVxVdxB/3N5N3znFGl7D7xpROqsi0Bpqn1Azi040y8gxx2nodQkwpdiN/jkbNVHN6kvhH5l
	RoMeFUh7Z7NKVh1K2yyZjX0hngIF6jxSTbhXHeMKJ3veYdxUonw==
X-Received: by 2002:ad4:5e8b:0:b0:8cc:ea95:2261 with SMTP id
 6a1803df08f44-8dea4a7d71bmr287524386d6.36.1782160748184; Mon, 22 Jun 2026
 13:39:08 -0700 (PDT)
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
References: <CAA1XrhPMekMqAnRkC-jV9rTsO4LHjzh=kxn6zQKMgBrqfrnp8A@mail.gmail.com>
 <62d126e2-fbf6-4ff5-a327-5c8d7b0b59d4@linux.alibaba.com>
In-Reply-To: <62d126e2-fbf6-4ff5-a327-5c8d7b0b59d4@linux.alibaba.com>
From: Tristan <TristanInSec@gmail.com>
Date: Mon, 22 Jun 2026 22:38:31 +0200
X-Gm-Features: AVVi8CflfjBiPR3cK6VuwTnJNwqwr1V-yDXv44gnxPwQEVhAE2NOnVbRMVwxB7A
Message-ID: <CAA1XrhMghmEfrY-bZtwWpQWzicD=1pRcGF0wzuCFhVxA_+wW8A@mail.gmail.com>
Subject: Re: Vulnerability Report - 5 findings in erofs-utils
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: multipart/mixed; boundary="00000000000054c0ad0654dda247"
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[TristanInSec@gmail.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3722-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[TristanInSec@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A64F6B251A

--00000000000054c0ad0654dda247
Content-Type: multipart/alternative; boundary="00000000000054c0ac0654dda245"

--00000000000054c0ac0654dda245
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gao Xiang,

Thank you for reviewing the reports. Attached are demo images for the 3
findings that crash cleanly under AddressSanitizer (erofs-pocs.tar.gz,
~1KB). Findings 2 and 4 are straightforward from the source and noted
below.

(I stripped their .img extension to prevent Gmail disallowing to attach)

Build ASAN binaries first:

  cd erofs-utils-1.8.5
  CFLAGS=3D"-fsanitize=3Daddress -g -O1" LDFLAGS=3D"-fsanitize=3Daddress" \
    ./configure --with-zstd --with-lz4 --with-zlib && make

  cd erofs-utils-1.9.1
  CFLAGS=3D"-fsanitize=3Daddress -g -O1" LDFLAGS=3D"-fsanitize=3Daddress" \
    ./configure --with-zstd --with-lz4 --with-zlib && make

---

1. ZSTD decompression heap OOB read (CWE-125, affects 1.8.5):

  mkdir -p /tmp/out1
  fsck.erofs --extract=3D/tmp/out1 poc1-zstd-oob.erofs.img

  ASAN reports: heap-buffer-overflow READ of size 8192 at decompress.c:71
  (memcpy from 100-byte buffer allocated at decompress.c:50)

  The image contains a ZSTD-compressed file where the ZSTD frame header
  declares Frame_Content_Size=3D100, but the extent metadata claims
  decodedlength=3D8192. malloc(100) is called, ZSTD decompresses 100 bytes,
  then memcpy reads 8192 bytes from the 100-byte buffer.

---

2. u64-to-u32 truncation heap overflow (CWE-190, affects 1.8.5):

  The type mismatch is at fsck/main.c:526: "unsigned int buffer_size"
  assigned from "map.m_llen" (u64). Any compressed extent with
  m_llen > 2^32 truncates the allocation size while the full u64 length
  flows into z_erofs_read_one_data() and write(). Visible directly in
  the source.

---

3. Off-by-one heap overflow in fsck path construction (CWE-193, affects
1.9.1):

  mkdir -p /tmp/e
  fsck.erofs --extract=3D/tmp/e poc3-obo-pathmax.erofs.img

  ASAN reports: heap-buffer-overflow WRITE of 1 byte at fsck/main.c:915
  (erofsfsck_dirent_iter)

  The image contains 17 directories nested to reach exactly PATH_MAX-1
  (4095) characters of accumulated path. The extraction prefix "/tmp/e"
  (6 chars) plus 15 levels of 255-char names plus one 249-char name
  totals 4095. The check at fsck/main.c compares prev_pos + namelen
  against PATH_MAX, which passes (4095 < 4096), but the null terminator
  write goes to buf[4096], one byte past the allocated buffer.

  IMPORTANT: the extract path must be exactly 6 characters ("/tmp/e")
  for the boundary to align.

---

4. Symlink i_size integer overflow (CWE-190, affects 1.9.1):

  The vulnerable code at fsck/main.c:797 computes malloc(i_size + 1)
  which wraps to malloc(0) when i_size is 0xFFFFFFFFFFFFFFFF.
  erofs_map_blocks() currently rejects such inodes before reaching the
  vulnerable path (BLK_ROUND_UP overflows to 0), but this is an
  incidental block, not a sanitization check -- the malloc overflow
  itself is unfixed.

---

5. Uncontrolled recursion in dump.erofs (CWE-674, affects 1.9.1):

  dump.erofs -S poc5-recursion.erofs.img

  ASAN reports: stack-overflow (SEGV on address near the stack limit)

  The image contains a root directory with a "loop" entry whose nid
  points back to the root (nid=3D0). dump.erofs -S traverses the directory
  tree recursively without cycle detection, causing unbounded stack growth.

---

Let me know if you need anything else.

Regards,
Tristan



Le jeu. 11 juin 2026 =C3=A0 03:40, Gao Xiang <hsiangkao@linux.alibaba.com> =
a
=C3=A9crit :

> Hi,
>
> On 2026/6/11 05:27, Tristan wrote:
> > Hello,
> >
> > I am reporting 5 vulnerabilities in erofs-utils across three versions.
> > All are triggered by crafted EROFS filesystem images.
> >
> > Findings summary:
> >
> >    - ZSTD decompression heap OOB read (erofs-utils 8a579d4, CVSS 5.5,
> > CWE-125)
> >    - u64-to-u32 truncation heap overflow (erofs-utils 1.8.5, CVSS 7.8,
> > CWE-190)
> >    - Off-by-one heap overflow in fsck path (erofs-utils 1.9.1, CVSS 6.2=
,
> > CWE-193)
> >    - Symlink extraction integer overflow (erofs-utils 1.9.1, CVSS 7.8,
> > CWE-190)
> >    - Uncontrolled recursion in dump.erofs (erofs-utils 1.9.1, CVSS 5.5,
> > CWE-674)
> >
> > I would appreciate acknowledgement of receipt and CVE assignment.
>
> Although I agree that some issues are obvious issues, but
> would you mind provide reproducible images (in gzipped-based64)
> at least?
>
> Thanks,
> Gao Xiang
>
>
> >
> > Regards,
> > Tristan
> >
>
>

--00000000000054c0ac0654dda245
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Gao Xiang,<br><br>Thank you for reviewing the reports. =
Attached are demo images for the 3<br>findings that crash cleanly under Add=
ressSanitizer (erofs-pocs.tar.gz,<br>~1KB). Findings 2 and 4 are straightfo=
rward from the source and noted<br>below.<br><div><br></div><div>(I strippe=
d their=C2=A0.img extension=C2=A0to prevent Gmail disallowing to attach)</d=
iv><div><br></div><div>Build ASAN binaries first:</div><br>=C2=A0 cd erofs-=
utils-1.8.5<br>=C2=A0 CFLAGS=3D&quot;-fsanitize=3Daddress -g -O1&quot; LDFL=
AGS=3D&quot;-fsanitize=3Daddress&quot; \<br>=C2=A0 =C2=A0 ./configure --wit=
h-zstd --with-lz4 --with-zlib &amp;&amp; make<br><br>=C2=A0 cd erofs-utils-=
1.9.1<br>=C2=A0 CFLAGS=3D&quot;-fsanitize=3Daddress -g -O1&quot; LDFLAGS=3D=
&quot;-fsanitize=3Daddress&quot; \<br>=C2=A0 =C2=A0 ./configure --with-zstd=
 --with-lz4 --with-zlib &amp;&amp; make<br><br>---<br><br>1. ZSTD decompres=
sion heap OOB read (CWE-125, affects 1.8.5):<br><br>=C2=A0 mkdir -p /tmp/ou=
t1<br>=C2=A0 fsck.erofs --extract=3D/tmp/out1 poc1-zstd-oob.erofs.img<br><b=
r>=C2=A0 ASAN reports: heap-buffer-overflow READ of size 8192 at decompress=
.c:71<br>=C2=A0 (memcpy from 100-byte buffer allocated at decompress.c:50)<=
br><br>=C2=A0 The image contains a ZSTD-compressed file where the ZSTD fram=
e header<br>=C2=A0 declares Frame_Content_Size=3D100, but the extent metada=
ta claims<br>=C2=A0 decodedlength=3D8192. malloc(100) is called, ZSTD decom=
presses 100 bytes,<br>=C2=A0 then memcpy reads 8192 bytes from the 100-byte=
 buffer.<br><br>---<br><br>2. u64-to-u32 truncation heap overflow (CWE-190,=
 affects 1.8.5):<br><br>=C2=A0 The type mismatch is at fsck/main.c:526: &qu=
ot;unsigned int buffer_size&quot;<br>=C2=A0 assigned from &quot;map.m_llen&=
quot; (u64). Any compressed extent with<br>=C2=A0 m_llen &gt; 2^32 truncate=
s the allocation size while the full u64 length<br>=C2=A0 flows into z_erof=
s_read_one_data() and write(). Visible directly in<br>=C2=A0 the source.<br=
><br>---<br><br>3. Off-by-one heap overflow in fsck path construction (CWE-=
193, affects 1.9.1):<br><br>=C2=A0 mkdir -p /tmp/e<br>=C2=A0 fsck.erofs --e=
xtract=3D/tmp/e poc3-obo-pathmax.erofs.img<br><br>=C2=A0 ASAN reports: heap=
-buffer-overflow WRITE of 1 byte at fsck/main.c:915<br>=C2=A0 (erofsfsck_di=
rent_iter)<br><br>=C2=A0 The image contains 17 directories nested to reach =
exactly PATH_MAX-1<br>=C2=A0 (4095) characters of accumulated path. The ext=
raction prefix &quot;/tmp/e&quot;<br>=C2=A0 (6 chars) plus 15 levels of 255=
-char names plus one 249-char name<br>=C2=A0 totals 4095. The check at fsck=
/main.c compares prev_pos + namelen<br>=C2=A0 against PATH_MAX, which passe=
s (4095 &lt; 4096), but the null terminator<br>=C2=A0 write goes to buf[409=
6], one byte past the allocated buffer.<br><br>=C2=A0 IMPORTANT: the extrac=
t path must be exactly 6 characters (&quot;/tmp/e&quot;)<br>=C2=A0 for the =
boundary to align.<br><br>---<br><br>4. Symlink i_size integer overflow (CW=
E-190, affects 1.9.1):<br><br>=C2=A0 The vulnerable code at fsck/main.c:797=
 computes malloc(i_size + 1)<br>=C2=A0 which wraps to malloc(0) when i_size=
 is 0xFFFFFFFFFFFFFFFF.<br>=C2=A0 erofs_map_blocks() currently rejects such=
 inodes before reaching the<br>=C2=A0 vulnerable path (BLK_ROUND_UP overflo=
ws to 0), but this is an<br>=C2=A0 incidental block, not a sanitization che=
ck -- the malloc overflow<br>=C2=A0 itself is unfixed.<br><br>---<br><br>5.=
 Uncontrolled recursion in dump.erofs (CWE-674, affects 1.9.1):<br><br>=C2=
=A0 dump.erofs -S poc5-recursion.erofs.img<br><br>=C2=A0 ASAN reports: stac=
k-overflow (SEGV on address near the stack limit)<br><br>=C2=A0 The image c=
ontains a root directory with a &quot;loop&quot; entry whose nid<br>=C2=A0 =
points back to the root (nid=3D0). dump.erofs -S traverses the directory<br=
>=C2=A0 tree recursively without cycle detection, causing unbounded stack g=
rowth.<br><br>---<br><br>Let me know if you need anything else.<br><div><br=
></div>Regards,<br>Tristan<br><br><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0jeu. 11=
 juin 2026 =C3=A0=C2=A003:40, Gao Xiang &lt;<a href=3D"mailto:hsiangkao@lin=
ux.alibaba.com">hsiangkao@linux.alibaba.com</a>&gt; a =C3=A9crit=C2=A0:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On 2026/6/11 05:27, Tristan wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; I am reporting 5 vulnerabilities in erofs-utils across three versions.=
<br>
&gt; All are triggered by crafted EROFS filesystem images.<br>
&gt; <br>
&gt; Findings summary:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 - ZSTD decompression heap OOB read (erofs-utils 8a579d4, =
CVSS 5.5,<br>
&gt; CWE-125)<br>
&gt;=C2=A0 =C2=A0 - u64-to-u32 truncation heap overflow (erofs-utils 1.8.5,=
 CVSS 7.8,<br>
&gt; CWE-190)<br>
&gt;=C2=A0 =C2=A0 - Off-by-one heap overflow in fsck path (erofs-utils 1.9.=
1, CVSS 6.2,<br>
&gt; CWE-193)<br>
&gt;=C2=A0 =C2=A0 - Symlink extraction integer overflow (erofs-utils 1.9.1,=
 CVSS 7.8,<br>
&gt; CWE-190)<br>
&gt;=C2=A0 =C2=A0 - Uncontrolled recursion in dump.erofs (erofs-utils 1.9.1=
, CVSS 5.5,<br>
&gt; CWE-674)<br>
&gt; <br>
&gt; I would appreciate acknowledgement of receipt and CVE assignment.<br>
<br>
Although I agree that some issues are obvious issues, but<br>
would you mind provide reproducible images (in gzipped-based64)<br>
at least?<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
<br>
&gt; <br>
&gt; Regards,<br>
&gt; Tristan<br>
&gt; <br>
<br>
</blockquote></div>

--00000000000054c0ac0654dda245--
--00000000000054c0ad0654dda247
Content-Type: application/gzip; name="erofs-pocs.tar.gz"
Content-Disposition: attachment; filename="erofs-pocs.tar.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_mqpog7l90>
X-Attachment-Id: f_mqpog7l90

H4sIABudOWoAA+3dTW/TSBzH8UlaaIECLVxAe/FhgEoQY6exc1wFlufHt5A+ICpKHSWphODEe+DM
q+i+l9VyoZy4sDeOaPGQ/6AhxK1AUwz4+5GcmeRvjW3NpT/NJO1lK3Hj6WC42siy5XCtnz0YKN+i
KErTVpC3cTuJ3NZompcgTppxuhRHSTMNorjVilsqiLzfyQRbg2G3n9/Ko+7G+m7n7VUfPUzwuQWA
n9ybnfevTVvPjzl15lM7zv1s58V/r9ovO9vbMyee7fx76p/xc6fyY/Ybrn9QqQO71afz40Onri7K
+/9ztbx9O/XWXCq/4xGd36Xtm6dYlP45VVNhGK52h91weX1z0vXV9vN8xGD03oxdd8Y3ZsxTzdcW
a9/wXAAAAAAAAAAAAMAPsPj3xQ/B6hWl5judmvqzdqGXrSw1suWs0esOHz7uPtmPLSBm/0eraP9H
c8nZ/xGl7cTs/0jiqM3+DwDYT3b/hzGXHwsTzjmpRvsiAAAAAPz63nWm1Fn5A3/S/m+3bjZFj2cB
tz49YQy3fkDGKKoflDGK6jPq6w3jbn1WxiiqH5IxiuqH1df71936ERmjqD4nYxTVj8oYRfVjMkZR
/biMUVSflzHG64HUF2SML+t19Yf0T8gYAAAAAIDfk3ZSu/n+tM345/J+GIadaitnTgAAAAAA8MXm
/PH8b99J/r9UbT98WgAAAAAA8MrmfO2s+Zv8b/foS/6/XG0lTAwAAAAAAB7ZnK+dNX+T/+138CX/
/1VtJUwMAAAAAAAe2ZyvnTV/k//tb+xJ/r9SbSVMDAAAAAAAHtmcr501f5P/7W/oS/6/Wm0lTAwA
AAAAAB7ZnK+dNX+T/+3/yJP8f63aSpgYAAAAAAA8sjlfO2v+Jv/PSl/y//VqK2FiAAAAAADwyOZ8
7az5m/x/SPqS/29UWwkTAwAAAACARzbna2fN3+T/w9KX/H+z2kqYGAAAAAAAPLI5Xztr/ib/H5G+
5P9b1VbCxAAAAAAA4JHN+dpZ8zf5f076kv9vV1sJEwMAAAAAgEc252tnzd/k/6PSl/x/p9pKmBgA
AAAAADyyOV87a/4m/x+TvuT/u9VWwsQAAAAAAOCRzfnaWfM3+f+49CX/36u2EiYGAAAAAACPbM7X
zpq/yf/z0pf8f7+qSpgSAAAAAAC8szn/lLPmf3qU+cu6JQAAAAAA4FkvW0ka/bWVrf5gPdsM1/rZ
g4Hva0RRlKatIG/jdhK5rdE0L0GcNON0KUpacRpEcSttN1UQ+b6RSbYGw24/v5VH3Y313c7bqz56
mOBzCwA/uTc771/bvvn9l9qEc+oFnwMAAAD4tUznx7vOlDq/x3n6UwoYOeP05fshG1nW258bBAAA
AAAAAPDdPgJ8ncngAHoBAA==
--00000000000054c0ad0654dda247--

