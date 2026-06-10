Return-Path: <linux-erofs+bounces-3566-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ieVHMv7WKWq9eAMAu9opvQ
	(envelope-from <linux-erofs+bounces-3566-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jun 2026 23:28:30 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4524466D149
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jun 2026 23:28:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="BGJi/OHY";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3566-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3566-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=2")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbJmR52J8z2ysW;
	Thu, 11 Jun 2026 07:28:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781126903;
	cv=pass; b=YNNtsONGq49H73UhO2gGrzUEs1DP/lH/HOECs+Zg8rvrLCrWGoKwkHudesH/N09ln8FBWkTpYzZl1pkk4CEBOKYhrI3uymm6BNFQia5sMoF30ayk8JC5mi4RFNsS6sPMD1ua9zf0g3I6EbheTFnkU17wnlzF+BW9RhaDYaRhBC3eWWmsIJb0xerWPFSpTj3eObmLDtI5WTD9VDfo37d77pTs8WaV7RpbBLqLDug77C0T6x78HH+zPP0bdCNJnSqDe8sSCscJLFIzLlRYYi8pswh4Gv7cQoTGE3QqbBkTG+TK/8B39GRjnt6KAr7OBsKwNcUh5XSnkWL0JEzC+kQpsA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781126903; c=relaxed/relaxed;
	bh=tLbvlz/DwsbkWmTw9fSRawU4sbWaWFKOpiQa3LmV35k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DSQfUKhdRu3gnGb7I8TIcxU97/nNcAF0LDSZdpER7u7uI+F0YlnV/8DbHzbVFBoZcyfc16SAU9aEuk4+P+gD39gUT+lim4WLlPtuf8rIX6gCpGXKI70Oa6e7EIa795pEokGyKEmiFjDOTEYU1N1dhs066/y03YYfmtkrIMjN1viVvWlwSxUu+AEwj0R1o0An3tZeFuq0vnGfIiAXZ8BOO0VaFHrD88vPEkAVqId2XVcoCOmM0dvEI5bMl2y9sps0jBDiidkureKsRh4oTXBdyrqtElYOeIVtfPM23zggL0YKktq+Y7GjHtT3sLYSAzutaLp4vPnW+iXz87lNy3KQVA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BGJi/OHY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=tristan.madani@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbJmP1PShz2yfD
	for <linux-erofs@lists.ozlabs.org>; Thu, 11 Jun 2026 07:28:20 +1000 (AEST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-9158629a220so804336085a.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jun 2026 14:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781126898; cv=none;
        d=google.com; s=arc-20240605;
        b=UD+vxdOhnl/fK51Xv5sIfBTf0WLurEBQnDNVDu+s+pgRM4tZgEa/ic8/0ePlyMXz9I
         LzTsRDGd4KqsxlPRqaehX5Xy7A9SvXuav5Vd8FeiA0Z59E7Y4kQwOsZYigczTffwLTQN
         zxQyz6TvvdtB9CVZMaUMmaiF09mcI5dtFQsq4MS73piCek3fqw+eYW7vBPlOURb7MuQq
         12MSmjGUg+gesEm0qBe80cnB/wiCgSrg7JIO7p4m0Tx9yZV8gk8fflfbXpPgF5E5ECbh
         c06BFZmxOD2gAhhULzQhSw+i+BaZCoRLdrD/QmGggmWo9rVD61jn9FlS4C/q+UVmpa4Z
         EekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tLbvlz/DwsbkWmTw9fSRawU4sbWaWFKOpiQa3LmV35k=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=NRsf7W5XWLbeXQ9bOMAXelK5sHRKXp5nxLRnAhsDz+Dv4Hksxv+OuCZ1rSE4MkA23z
         EBt0IKOqn0ufTsNIy/yPQVoWuWA1MjQhMKp2Tyz2/K0IRCNJjGSUsuG0YtFboTVv6WmL
         JzdElI1t22uGtZO8H4A9K4suL9rcX/8KSaqLDw02FbFJ6PZENSHXVWwZakZeK/SeFLzL
         tmB60xOayEfC70cHERj6g6GqGwVPN+C/GwYM6anPGhr3GDX0ZbMg29+hoAkrpDHS3ozs
         ATPle86M0BaTaXw81HIp0mYqyqpqSW/a7qRceJvgDL44/n8g7zf7RoovjcYygpmKW/EM
         oPYA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781126898; x=1781731698; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tLbvlz/DwsbkWmTw9fSRawU4sbWaWFKOpiQa3LmV35k=;
        b=BGJi/OHYHzFZiICLotgp9ZO9W3ew21uJhokYmECxph9s+ysItorVEbrn1VD4wApvnc
         yaL0qFATEG88a7ctwHBiXu4rS85xHuJ2gpDjYHMLinOqKJb1e+7PqfCzaA0LxY/TRVwe
         I2xKKyy4wLUJHnCTtBjZepij1rNWlJJ94JHdc/f43rNAOApAP3YRCOElP2vwxD5JSVkg
         09x83O5m0xUA5D77jmP7Mw9PBgsHeybiVqSV7ZSx3JZD2Ny5dPEeWyPbWsiv/G8xdi3z
         FN4AO5EYAbOS8sLWA2AJSMcxOUQQNC/J6o5yJ6uyqaSsSzT0q6gVG5bCr81hWIvzHSSe
         CtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781126898; x=1781731698;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLbvlz/DwsbkWmTw9fSRawU4sbWaWFKOpiQa3LmV35k=;
        b=Rep3dKWDjIDG/h/wl7Z126uHVCZOBxqaAOLZ14JlYJtc8nKZlAkQ/BuD5qEULuhhpI
         XB9K3j9j3vM6yvAw1e8LX1OSEmvYMXR5aqDrKayLvPMiqHYE5UAkYhl7NTghx2l1YE6w
         QhMrzrZEDEYL+Eqr0r7txCsbkUKh8PbEkuD1MMN1LRLOdSklI9CTlmzP+JtS8bl9+Sxc
         A5xRT3hhR36QBPrNKuums4dYZbLkoFFHS/IQ6DsmNPNjCEixlqy8bliNPmU3l9DwYaix
         7bmGQsXQyREItpbBD0OYMiVMbYSVXzd0CsxJGrazWEQYItldABho9hURUVaFIp7xNrAE
         STDw==
X-Gm-Message-State: AOJu0Yw6uTNCxk05OV6qxpeHIDM+exN5aZJayL0yotW1YZqvVFOwYxG1
	fmWUhC6uGaTxYYv5s144PM8kxX+6iNhTsMxvI2z0GI6SnD3uwA/2ibnHSfF0RnDlbVUaHwU1qyG
	VlDSKoMd7spmQWwMkk1WAcAdNOTif5X5EokwF
X-Gm-Gg: Acq92OFMVchQKZZ7htO+nwEi859kynZ2Ognh5iu4dq9e9+Gy8W+xXBDro5YvdxgONHm
	kTGenJFy8FyFEiI6kDPfpzunA1MtpJqBXwlsAhHXdVNYJnjaXSll4CcLdbn2rwknawrT6nyX4VK
	UwoN032EYEU39AvJbSVAfljFpR2fGTV8xtryD1h8uAzxlLbQN0dxu370WEGj257thk6Hzhq4O5W
	UjLX7pzJA9FmpCYPaf1KsvKkF3Hx+oVZDqFRi3sR8sQXsGph//PMnf+EaAyYe5HgtLpddfYJEpt
	ruMsEqqfAu4+zbCPCxxQB0JlKAIPuAprMhtVgAEze5bFeZwZbOYA3Ej3Xh43zjGhrTtFzcnJdHy
	aQTLTsYE8zdJX0UyZGYYLn1JtRLc5gsZFtZ537pCvAdVizygPVI37yqbAANKN0g==
X-Received: by 2002:a05:620a:439d:b0:915:6a2b:626c with SMTP id
 af79cd13be357-915e8346e6bmr1465491485a.51.1781126897546; Wed, 10 Jun 2026
 14:28:17 -0700 (PDT)
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
From: Tristan <TristanInSec@gmail.com>
Date: Wed, 10 Jun 2026 23:27:39 +0200
X-Gm-Features: AVVi8CdjtLe8OAXeYLt8avyl6r3yOGfFQz5TaFrG3Y-5iSRznIVRG6AyQftQuoc
Message-ID: <CAA1XrhPMekMqAnRkC-jV9rTsO4LHjzh=kxn6zQKMgBrqfrnp8A@mail.gmail.com>
Subject: Vulnerability Report - 5 findings in erofs-utils
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/mixed; boundary="00000000000007b76a0653ecec39"
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,
	URI_NOVOWEL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.10 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3566-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+,5:+,6:+,7:+,8:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[TristanInSec@gmail.com,linux-erofs@lists.ozlabs.org];
	HAS_ATTACHMENT(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4524466D149

--00000000000007b76a0653ecec39
Content-Type: multipart/alternative; boundary="00000000000007b76a0653ecec37"

--00000000000007b76a0653ecec37
Content-Type: text/plain; charset="UTF-8"

Hello,

I am reporting 5 vulnerabilities in erofs-utils across three versions.
All are triggered by crafted EROFS filesystem images.

Findings summary:

  - ZSTD decompression heap OOB read (erofs-utils 8a579d4, CVSS 5.5,
CWE-125)
  - u64-to-u32 truncation heap overflow (erofs-utils 1.8.5, CVSS 7.8,
CWE-190)
  - Off-by-one heap overflow in fsck path (erofs-utils 1.9.1, CVSS 6.2,
CWE-193)
  - Symlink extraction integer overflow (erofs-utils 1.9.1, CVSS 7.8,
CWE-190)
  - Uncontrolled recursion in dump.erofs (erofs-utils 1.9.1, CVSS 5.5,
CWE-674)

I would appreciate acknowledgement of receipt and CVE assignment.

Regards,
Tristan

--00000000000007b76a0653ecec37
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>I am reporting 5 vulnerabilities in erofs-ut=
ils across three versions.<br>All are triggered by crafted EROFS filesystem=
 images.<br><br>Findings summary:<br><br>=C2=A0 - ZSTD decompression heap O=
OB read (erofs-utils 8a579d4, CVSS 5.5, CWE-125)<br>=C2=A0 - u64-to-u32 tru=
ncation heap overflow (erofs-utils 1.8.5, CVSS 7.8, CWE-190)<br>=C2=A0 - Of=
f-by-one heap overflow in fsck path (erofs-utils 1.9.1, CVSS 6.2, CWE-193)<=
br>=C2=A0 - Symlink extraction integer overflow (erofs-utils 1.9.1, CVSS 7.=
8, CWE-190)<br>=C2=A0 - Uncontrolled recursion in dump.erofs (erofs-utils 1=
.9.1, CVSS 5.5, CWE-674)<br><br>I would appreciate acknowledgement of recei=
pt and CVE assignment.<br><br>Regards,<br>Tristan<br></div>

--00000000000007b76a0653ecec37--
--00000000000007b76a0653ecec39
Content-Type: text/plain; charset="US-ASCII"; name="u64-to-u32-truncation-overflow.txt"
Content-Disposition: attachment; 
	filename="u64-to-u32-truncation-overflow.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mq8kxtzs1>
X-Attachment-Id: f_mq8kxtzs1

SGVhcCBPdmVyZmxvdyB2aWEgdTY0LXRvLXUzMiBUcnVuY2F0aW9uIGluIEZyYWdtZW50IERlY29t
cHJlc3Npb24KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQpDVlNTIDMuMTogNy44IChBVjpML0FDOkwvUFI6Ti9VSTpSL1M6
VS9DOkgvSTpIL0E6SCkKQ1dFOiBDV0UtMTkwIChJbnRlZ2VyIE92ZXJmbG93KQpUYXJnZXQ6IGVy
b2ZzLXV0aWxzIDEuOC41ICh2ZXJpZmllZCB1bmZpeGVkIGF0IEhFQUQsIGNvbW1pdCA4Y2Q4NzJk
KQoKSW4gZXJvZnNfdmVyaWZ5X2lub2RlX2RhdGEoKSwgYnVmZmVyX3NpemUgaXMgZGVjbGFyZWQg
YXMgdW5zaWduZWQgaW50CigzMi1iaXQpIGJ1dCBhc3NpZ25lZCBmcm9tIG1hcC5tX2xsZW4gd2hp
Y2ggaXMgdTY0LiBUaGUgdHJ1bmNhdGlvbgpjYXVzZXMgYW4gdW5kZXJzaXplZCBhbGxvY2F0aW9u
OyB0aGUgc3Vic2VxdWVudCByZWFkIHVzZXMgdGhlIGZ1bGwKNjQtYml0IGxlbmd0aCwgb3ZlcmZs
b3dpbmcgdGhlIGJ1ZmZlci4KClZ1bG5lcmFibGUgY29kZSAoZnNjay9tYWluLmMpOgoKICB1bnNp
Z25lZCBpbnQgcmF3X3NpemUgPSAwLCBidWZmZXJfc2l6ZSA9IDA7ICAvLyBsaW5lIDUyNjogdTMy
CgogIGlmIChtYXAubV9sbGVuID4gYnVmZmVyX3NpemUpIHsgICAgIC8vIGxpbmUgNTkzOiBjb21w
YXJpc29uIHByb21vdGVzCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8g
YnVmZmVyX3NpemUgdG8gdTY0LCBwYXNzZXMKICAgICAgYnVmZmVyX3NpemUgPSBtYXAubV9sbGVu
OyAgICAgICAvLyBsaW5lIDU5NjogVFJVTkNBVElPTiB1NjQtPnUzMgogICAgICBuZXdidWZmZXIg
PSByZWFsbG9jKGJ1ZmZlciwgYnVmZmVyX3NpemUpOyAgLy8gdW5kZXJzaXplZCBhbGxvYwogIH0K
CiAgcmV0ID0gel9lcm9mc19yZWFkX29uZV9kYXRhKGlub2RlLCAmbWFwLCByYXcsIGJ1ZmZlciwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMCwgbWFwLm1fbGxlbiwgZmFsc2UpOyAgLy8g
d3JpdGVzIGZ1bGwgdTY0CgpTb3VyY2UgdHlwZSAoaW5jbHVkZS9lcm9mcy9pbnRlcm5hbC5oOjM3
OCk6CgogIHN0cnVjdCBlcm9mc19tYXBfYmxvY2tzIHsKICAgICAgdTY0IG1fcGxlbiwgbV9sbGVu
OyAgIC8vIDY0LWJpdAogIH07CgpPdmVyZmxvdyBhcml0aG1ldGljOgogIG1fbGxlbiA9IDB4MTAw
MDAwMDAxICg0R0IgKyAxKQogIGJ1ZmZlcl9zaXplID0gKHVpbnQzMl90KTB4MTAwMDAwMDAxID0g
MHgxCiAgcmVhbGxvYyhidWZmZXIsIDEpIC0+IHpfZXJvZnNfcmVhZF9vbmVfZGF0YSB3cml0ZXMg
fjRHQgoKSW1wYWN0OiBoZWFwIG92ZXJmbG93IHdpdGggYXR0YWNrZXItY29udHJvbGxlZCBzaXpl
ICh1cCB0byB+NEdCIHBlcgpleHRlbnQpIGFuZCBhdHRhY2tlci1jb250cm9sbGVkIGNvbnRlbnQg
ZnJvbSB0aGUgRVJPRlMgaW1hZ2UgZGF0YQpibG9ja3MuIGZzY2suZXJvZnMgcnVucyBpbiBBbmRy
b2lkIGJ1aWxkIHBpcGVsaW5lcywgaW5pdHJhbWZzCnZhbGlkYXRpb24sIGFuZCBzeXN0ZW0gaW1h
Z2UgdmVyaWZpY2F0aW9uLCBvZnRlbiBhcyByb290LgoKRml4OiBjaGFuZ2UgYnVmZmVyX3NpemUg
ZnJvbSB1bnNpZ25lZCBpbnQgdG8gdTY0OgogIC0gIHVuc2lnbmVkIGludCByYXdfc2l6ZSA9IDAs
IGJ1ZmZlcl9zaXplID0gMDsKICArICB1NjQgcmF3X3NpemUgPSAwLCBidWZmZXJfc2l6ZSA9IDA7
Cg==
--00000000000007b76a0653ecec39
Content-Type: text/plain; charset="US-ASCII"; name="fsck-path-off-by-one.txt"
Content-Disposition: attachment; filename="fsck-path-off-by-one.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mq8kxu0l3>
X-Attachment-Id: f_mq8kxu0l3

T2ZmLWJ5LU9uZSBIZWFwIE92ZXJmbG93IGluIGZzY2suZXJvZnMgUGF0aCBDb25zdHJ1Y3Rpb24K
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQpDVlNTIDMuMTogNi4yIChBVjpML0FDOkwvUFI6Ti9VSTpSL1M6VS9DOk4vSTpOL0E6SCkKQ1dF
OiBDV0UtMTkzIChPZmYtYnktb25lIEVycm9yKQpUYXJnZXQ6IGVyb2ZzLXV0aWxzIDEuOS4xICh2
ZXJpZmllZCB1bmZpeGVkIGF0IEhFQUQsIGNvbW1pdCBkM2ZiY2NiKQoKSW4gZXJvZnNmc2NrX2Rp
cmVudF9pdGVyKCksIHRoZSBib3VuZHMgY2hlY2sgZm9yIHBhdGggY29uc3RydWN0aW9uCmRvZXMg
bm90IGFjY291bnQgZm9yIHRoZSBwcmVwZW5kZWQgJy8nIHNlcGFyYXRvciwgYWxsb3dpbmcgYSBu
dWxsCmJ5dGUgdG8gYmUgd3JpdHRlbiBvbmUgYnl0ZSBwYXN0IHRoZSBQQVRIX01BWC1zaXplZCBo
ZWFwIGJ1ZmZlci4KClZ1bG5lcmFibGUgY29kZSAoZnNjay9tYWluLmM6OTAxLTkxNSk6CgogIGlm
IChwcmV2X3BvcyArIGN0eC0+ZGVfbmFtZWxlbiA+PSBQQVRIX01BWCkgeyAgLy8gbGluZSA5MDQK
ICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOyAgICAgICAgICAgICAgICAgICAgICAgIC8vIGNoZWNr
IG1pc3NlcyAnLycKICB9CgogIGZzY2tjZmcuZXh0cmFjdF9wYXRoW2N1cnJfcG9zKytdID0gJy8n
OyAgICAgICAgIC8vIGxpbmUgOTExOiArMQogIHN0cm5jcHkoZnNja2NmZy5leHRyYWN0X3BhdGgg
KyBjdXJyX3BvcywKICAgICAgICAgIGN0eC0+ZG5hbWUsIGN0eC0+ZGVfbmFtZWxlbik7ICAgICAg
ICAgICAgLy8gbGluZSA5MTItOTEzCiAgY3Vycl9wb3MgKz0gY3R4LT5kZV9uYW1lbGVuOyAgICAg
ICAgICAgICAgICAgICAgIC8vIGxpbmUgOTE0CiAgZnNja2NmZy5leHRyYWN0X3BhdGhbY3Vycl9w
b3NdID0gJ1wwJzsgICAgICAgICAgIC8vIGxpbmUgOTE1OiBPT0IKCkJ1ZmZlcjogbWFsbG9jKFBB
VEhfTUFYKSAtPiB2YWxpZCBpbmRpY2VzIDAgdG8gNDA5NS4KCkNvbmNyZXRlIGV4YW1wbGUgKFBB
VEhfTUFYID0gNDA5Nik6CiAgcHJldl9wb3MgPSA0MDkwLCBkZV9uYW1lbGVuID0gNQogIENoZWNr
OiA0MDkwICsgNSA9IDQwOTUgPCA0MDk2IC0+IFBBU1NFUwogICcvJyBhdCBpbmRleCA0MDkwLCBu
YW1lIGF0IDQwOTEtNDA5NSwgJ1wwJyBhdCA0MDk2IC0+IE9PQgoKVGhlIGNoZWNrIGFsbG93cyBw
cmV2X3BvcyArIGRlX25hbWVsZW4gdXAgdG8gUEFUSF9NQVggLSAxLCBidXQKdGhlIGFjdHVhbCB3
cml0ZSBleHRlbmRzIHRvIHByZXZfcG9zICsgMSArIGRlX25hbWVsZW4gZHVlIHRvICcvJy4KTWF4
aW11bSBPT0IgaW5kZXg6IFBBVEhfTUFYIChvbmUgYnl0ZSBwYXN0IGFsbG9jYXRpb24pLgoKSW1w
YWN0OiBzaW5nbGUgbnVsbCBieXRlIHdyaXR0ZW4gcGFzdCBhIGhlYXAgYnVmZmVyIChudWxsIGJ5
dGUKcG9pc29uaW5nKS4gT24gZ2xpYmMsIHRoaXMgY29ycnVwdHMgdGhlIHNpemUgbWV0YWRhdGEg
b2YgdGhlCmFkamFjZW50IGhlYXAgY2h1bmsgLS0gYSBrbm93biBleHBsb2l0YXRpb24gcHJpbWl0
aXZlIChIb3VzZSBvZgpFaW5oZXJqYXIpIHRoYXQgZW5hYmxlcyBvdmVybGFwcGluZyBhbGxvY2F0
aW9ucy4gQXQgbWluaW11bSwKaGVhcCBjb3JydXB0aW9uIGxlYWRzIHRvIGEgY3Jhc2guCgpGaXg6
IGFjY291bnQgZm9yIHRoZSBzZXBhcmF0b3IgaW4gdGhlIGJvdW5kcyBjaGVjazoKICAtICBpZiAo
cHJldl9wb3MgKyBjdHgtPmRlX25hbWVsZW4gPj0gUEFUSF9NQVgpIHsKICArICBpZiAocHJldl9w
b3MgKyBjdHgtPmRlX25hbWVsZW4gKyAxID49IFBBVEhfTUFYKSB7Cg==
--00000000000007b76a0653ecec39
Content-Type: text/plain; charset="US-ASCII"; name="zstd-decomp-oob-read.txt"
Content-Disposition: attachment; filename="zstd-decomp-oob-read.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mq8kxtz20>
X-Attachment-Id: f_mq8kxtz20

SGVhcCBPT0IgUmVhZCBpbiBaU1REIERlY29tcHJlc3Npb24gdmlhIEZyYW1lIFNpemUgTWlzbWF0
Y2gKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KQ1ZTUyAzLjE6IDUuNSAoQVY6TC9BQzpML1BSOk4vVUk6Ui9TOlUvQzpIL0k6Ti9B
Ok4pCkNXRTogQ1dFLTEyNSAoT3V0LW9mLWJvdW5kcyBSZWFkKQpUYXJnZXQ6IGVyb2ZzLXV0aWxz
IChjb21taXQgOGE1NzlkNCwgdmVyaWZpZWQgYXQgSEVBRCkKCnpfZXJvZnNfZGVjb21wcmVzc196
c3RkKCkgYWxsb2NhdGVzIGEgZGVjb21wcmVzc2lvbiBidWZmZXIgYmFzZWQKb24gWlNURF9nZXRG
cmFtZUNvbnRlbnRTaXplKCkgKGZyb20gdGhlIGNvbXByZXNzZWQgZnJhbWUgaGVhZGVyKSwKYnV0
IGNvcGllcyBycS0+ZGVjb2RlZGxlbmd0aCBieXRlcyAoZnJvbSB0aGUgZmlsZXN5c3RlbSBleHRl
bnQKbWV0YWRhdGEpIHRvIHRoZSBvdXRwdXQuIEJvdGggdmFsdWVzIGFyZSBpbmRlcGVuZGVudGx5
IGF0dGFja2VyLQpjb250cm9sbGVkIGluIGEgY3JhZnRlZCBFUk9GUyBpbWFnZS4KClZ1bG5lcmFi
bGUgY29kZSAobGliL2RlY29tcHJlc3MuYzo1Mi03Nik6CgogIHRvdGFsID0gWlNURF9nZXRGcmFt
ZUNvbnRlbnRTaXplKHNyYyArIGlucHV0bWFyZ2luLCAuLi4pOwogIC8vIHRvdGFsID0gZnJvbSBa
U1REIGZyYW1lIGhlYWRlciAoYXR0YWNrZXItY29udHJvbGxlZCkKCiAgYnVmZiA9IG1hbGxvYyh0
b3RhbCk7ICAvLyBhbGxvY2F0ZXMgYmFzZWQgb24gZnJhbWUgaGVhZGVyCgogIHJldCA9IFpTVERf
ZGVjb21wcmVzcyhkZXN0LCB0b3RhbCwgLi4uKTsgIC8vIGZpbGxzICd0b3RhbCcgYnl0ZXMKCiAg
bWVtY3B5KHJxLT5vdXQsIGRlc3QgKyBycS0+ZGVjb2RlZHNraXAsCiAgICAgICAgIHJxLT5kZWNv
ZGVkbGVuZ3RoIC0gcnEtPmRlY29kZWRza2lwKTsKICAvLyBjb3BpZXMgZGVjb2RlZGxlbmd0aCBi
eXRlcyBmcm9tIHRvdGFsLXNpemVkIGJ1ZmZlcgoKT3ZlcmZsb3cgYXJpdGhtZXRpYzoKICBGcmFt
ZV9Db250ZW50X1NpemUgPSAxMDAgKFpTVEQgaGVhZGVyKQogIG1fbGxlbiA9IDEyTUIgKGV4dGVu
dCBtZXRhZGF0YSwgdXAgdG8gWl9FUk9GU19QQ0xVU1RFUl9NQVhfRFNJWkUpCiAgbWFsbG9jKDEw
MCkgLT4gbWVtY3B5IHJlYWRzIDEyTUIgZnJvbSAxMDAtYnl0ZSBidWZmZXIgLT4gfjEyTUIgT09C
CgpTaWJsaW5nIGNvbXBhcmlzb246IGFsbCBvdGhlciBkZWNvbXByZXNzaW9uIGJhY2tlbmRzIChM
WjQsIExaTUEsCkRFRkxBVEUsIFFQTCkgYWxsb2NhdGUgYmFzZWQgb24gcnEtPmRlY29kZWRsZW5n
dGgsIG5vdCB0aGUKY29tcHJlc3NlZCBmcmFtZSdzIHNlbGYtZGVjbGFyZWQgc2l6ZS4gT25seSBa
U1REIGlzIHZ1bG5lcmFibGUuCgpJbXBhY3Q6IH4xMk1CIGhlYXAgT09CIHJlYWQuIEluIGVyb2Zz
ZnVzZSwgbGVha2VkIGhlYXAgZGF0YSBpcwpyZXR1cm5lZCB2aWEgRlVTRSB0byB0aGUgcmVhZGlu
ZyBwcm9jZXNzLiBJbiBmc2NrLmVyb2ZzIC0tZXh0cmFjdCwKbGVha2VkIGRhdGEgaXMgd3JpdHRl
biB0byBleHRyYWN0ZWQgZmlsZXMuCgpGaXg6IGFsbG9jYXRlIHRoZSBpbnRlcm1lZGlhdGUgYnVm
ZmVyIGJhc2VkIG9uIHJxLT5kZWNvZGVkbGVuZ3RoCihjb25zaXN0ZW50IHdpdGggYWxsIG90aGVy
IGJhY2tlbmRzKSwgb3IgdmFsaWRhdGUgdGhhdApaU1REX2dldEZyYW1lQ29udGVudFNpemUoKSA+
PSBycS0+ZGVjb2RlZGxlbmd0aC4K
--00000000000007b76a0653ecec39
Content-Type: text/plain; charset="US-ASCII"; name="symlink-integer-overflow.txt"
Content-Disposition: attachment; filename="symlink-integer-overflow.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mq8kxu072>
X-Attachment-Id: f_mq8kxu072

SW50ZWdlciBPdmVyZmxvdyBpbiBTeW1saW5rIEV4dHJhY3Rpb24gTGVhZGluZyB0byBIZWFwIE92
ZXJmbG93Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09CkNWU1MgMy4xOiA3LjggKEFWOkwvQUM6TC9QUjpOL1VJOlIvUzpVL0M6
SC9JOkgvQTpIKQpDV0U6IENXRS0xOTAgKEludGVnZXIgT3ZlcmZsb3cpClRhcmdldDogZXJvZnMt
dXRpbHMgMS45LjEgKHZlcmlmaWVkIHVuZml4ZWQgYXQgSEVBRCwgY29tbWl0IGQzZmJjY2IpCgpl
cm9mc19leHRyYWN0X3N5bWxpbmsoKSBhbGxvY2F0ZXMgYSBidWZmZXIgdXNpbmcgbWFsbG9jKGlf
c2l6ZSArIDEpCndoZXJlIGlfc2l6ZSBpcyBhIDY0LWJpdCB2YWx1ZSByZWFkIGRpcmVjdGx5IGZy
b20gdGhlIG9uLWRpc2sgaW5vZGUKd2l0aCBubyB1cHBlciBib3VuZCB2YWxpZGF0aW9uLiBXaGVu
IGlfc2l6ZSBlcXVhbHMgVUlOVDY0X01BWCwgdGhlCmFkZGl0aW9uIHdyYXBzIHRvIHplcm8sIGFu
ZCBtYWxsb2MoMCkgcmV0dXJucyBhIG1pbmltYWwgYWxsb2NhdGlvbi4KVGhlIHN1YnNlcXVlbnQg
ZXJvZnNfcHJlYWQoKSB3cml0ZXMgaV9zaXplIGJ5dGVzIGludG8gdGhpcyB0aW55CmJ1ZmZlci4K
ClZ1bG5lcmFibGUgY29kZSAoZnNjay9tYWluLmM6Nzk3LTgwNyk6CgogIGJ1ZiA9IG1hbGxvYyhp
bm9kZS0+aV9zaXplICsgMSk7ICAgICAgICAvLyB3cmFwcyB0byAwIGF0IFVJTlQ2NF9NQVgKICBp
ZiAoIWJ1ZikgeyByZXQgPSAtRU5PTUVNOyBnb3RvIG91dDsgfSAgLy8gbWFsbG9jKDApIHJldHVy
bnMgbm9uLU5VTEwKCiAgcmV0ID0gZXJvZnNfcHJlYWQoJnZmLCBidWYsIGlub2RlLT5pX3NpemUs
IDApOyAgLy8gd3JpdGVzIGlfc2l6ZSBieXRlcwoKU291cmNlIG9mIGlfc2l6ZSAobGliL25hbWVp
LmM6MTAwKToKCiAgdmktPmlfc2l6ZSA9IGxlNjRfdG9fY3B1KGRpZS0+aV9zaXplKTsgIC8vIHJh
dyA2NC1iaXQsIG5vIHZhbGlkYXRpb24KCk92ZXJmbG93IGFyaXRobWV0aWM6CiAgaV9zaXplID0g
MHhGRkZGRkZGRkZGRkZGRkZGCiAgbWFsbG9jKDB4RkZGRkZGRkZGRkZGRkZGRiArIDEpID0gbWFs
bG9jKDApIC0+IH4xNi0zMiBieXRlIGFsbG9jYXRpb24KICBlcm9mc19wcmVhZCB3cml0ZXMgMHhG
RkZGRkZGRkZGRkZGRkZGIGJ5dGVzIGludG8gMTYtMzIgYnl0ZSBidWZmZXIKCk9uIDMyLWJpdCBw
bGF0Zm9ybXMsIGNvbXBhY3QgaW5vZGVzICgzMi1iaXQgaV9zaXplID0gMHhGRkZGRkZGRikKYWxz
byB0cmlnZ2VyIHRoZSBzYW1lIHBhdHRlcm4gd2hlbiBzaXplX3QgaXMgMzIgYml0cy4KCkltcGFj
dDogaGVhcCBvdmVyZmxvdyB3aXRoIGF0dGFja2VyLWNvbnRyb2xsZWQgd3JpdGUgc2l6ZSBhbmQK
YXR0YWNrZXItY29udHJvbGxlZCBjb250ZW50IChmcm9tIEVST0ZTIGltYWdlIGRhdGEgYmxvY2tz
KS4gVGhpcwpwcm92aWRlcyBhIHdyaXRlLXdoYXQtd2hlcmUgcHJpbWl0aXZlIG9uIHRoZSBoZWFw
LgoKRml4OiB2YWxpZGF0ZSBpX3NpemUgYmVmb3JlIGFsbG9jYXRpb246CiAgaWYgKGlub2RlLT5p
X3NpemUgPiBQQVRIX01BWCB8fCBpbm9kZS0+aV9zaXplID4gU0laRV9NQVggLSAxKSB7CiAgICAg
IGVyb2ZzX2Vycigic3ltbGluayB0b28gbGFyZ2UiKTsKICAgICAgcmV0dXJuIC1FRlNDT1JSVVBU
RUQ7CiAgfQogIGJ1ZiA9IG1hbGxvYyhpbm9kZS0+aV9zaXplICsgMSk7Cg==
--00000000000007b76a0653ecec39
Content-Type: text/plain; charset="US-ASCII"; name="dump-erofs-recursion.txt"
Content-Disposition: attachment; filename="dump-erofs-recursion.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mq8kxu174>
X-Attachment-Id: f_mq8kxu174

VW5jb250cm9sbGVkIFJlY3Vyc2lvbiBpbiBkdW1wLmVyb2ZzIERpcmVjdG9yeSBUcmF2ZXJzYWwK
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQpDVlNTIDMuMTogNS41IChBVjpML0FDOkwvUFI6Ti9VSTpSL1M6VS9DOk4vSTpOL0E6SCkKQ1dF
OiBDV0UtNjc0IChVbmNvbnRyb2xsZWQgUmVjdXJzaW9uKQpUYXJnZXQ6IGVyb2ZzLXV0aWxzIDEu
OS4xICh2ZXJpZmllZCB1bmZpeGVkIGF0IEhFQUQsIGNvbW1pdCBkM2ZiY2NiKQoKZXJvZnNkdW1w
X3JlYWRkaXIoKSBpbiBkdW1wLmVyb2ZzIHJlY3Vyc2l2ZWx5IHRyYXZlcnNlcyBkaXJlY3Rvcmll
cwp3aXRob3V0IGRlcHRoIGxpbWl0aW5nIG9yIGN5Y2xlIGRldGVjdGlvbi4gQSBjcmFmdGVkIEVS
T0ZTIGltYWdlCndpdGggY2lyY3VsYXIgZGlyZWN0b3J5IHJlZmVyZW5jZXMgY2F1c2VzIHVuYm91
bmRlZCByZWN1cnNpb24sCmV4aGF1c3RpbmcgdGhlIHByb2Nlc3Mgc3RhY2suCgpUaGUgZGV2ZWxv
cGVyIGFja25vd2xlZGdlZCB0aGlzIHdpdGggYSBjb21tZW50IGF0IGxpbmUgMzYyOgogIC8qIFhY
WFg6IHRoZSBkaXIgZGVwdGggc2hvdWxkIGJlIHJlc3RyaWN0ZWQgaW4gb3JkZXIgdG8gYXZvaWQg
bG9vcHMgKi8KClZ1bG5lcmFibGUgY29kZSAoZHVtcC9tYWluLmM6MzYyLTM3MSk6CgogIC8qIFhY
WFg6IHRoZSBkaXIgZGVwdGggc2hvdWxkIGJlIHJlc3RyaWN0ZWQgLi4uICovCiAgaWYgKFNfSVNE
SVIodmkuaV9tb2RlKSkgewogICAgICBzdHJ1Y3QgZXJvZnNfZGlyX2NvbnRleHQgbmN0eCA9IHsK
ICAgICAgICAgIC5mbGFncyA9IGN0eC0+ZGlyID8gRVJPRlNfUkVBRERJUl9WQUxJRF9QTklEIDog
MCwKICAgICAgICAgIC5wbmlkID0gY3R4LT5kaXIgPyBjdHgtPmRpci0+bmlkIDogMCwKICAgICAg
ICAgIC5kaXIgPSAmdmksCiAgICAgICAgICAuY2IgPSBlcm9mc2R1bXBfZGlyZW50X2l0ZXIsCiAg
ICAgIH07CiAgICAgIHJldHVybiBlcm9mc19pdGVyYXRlX2RpcigmbmN0eCwgZmFsc2UpOyAgLy8g
bm8gZ3VhcmQKICB9CgpTaWJsaW5nIGNvbXBhcmlzb24gLS0gZnNjay5lcm9mcyBoYXMgYm90aCBw
cm90ZWN0aW9ucyAoZnNjay9tYWluLmMpOgoKICBpZiAoZnNja2NmZy5kaXJzdGFjay50b3AgPj0g
QVJSQVlfU0laRShmc2NrY2ZnLmRpcnN0YWNrLmRpcnMpKQogICAgICByZXR1cm4gLUVOQU1FVE9P
TE9ORzsgICAgICAgICAgICAgICAgICAgIC8vIGRlcHRoIGxpbWl0CiAgZm9yIChpID0gMDsgaSA8
IGZzY2tjZmcuZGlyc3RhY2sudG9wOyArK2kpCiAgICAgIGlmIChpbm9kZS5uaWQgPT0gZnNja2Nm
Zy5kaXJzdGFjay5kaXJzW2ldKQogICAgICAgICAgcmV0dXJuIC1FTE9PUDsgICAgICAgICAgICAg
ICAgICAgICAgIC8vIGN5Y2xlIGRldGVjdGlvbgoKVHJpZ2dlcjogZGlyZWN0b3J5IEEgY29udGFp
bnMgZW50cnkgcG9pbnRpbmcgdG8gZGlyZWN0b3J5IEIsIEIgcG9pbnRzCmJhY2sgdG8gQS4gRWFj
aCByZWN1cnNpdmUgY2FsbCBhbGxvY2F0ZXMgc3RydWN0IGVyb2ZzX2lub2RlICsgY29udGV4dAor
IGJsb2NrIGJ1ZmZlciBvbiB0aGUgc3RhY2suIFN0YWNrIGV4aGF1c3Rpb24gcHJvZHVjZXMgU0lH
U0VHVi4KCkltcGFjdDogZGV0ZXJtaW5pc3RpYyBjcmFzaCAoZGVuaWFsIG9mIHNlcnZpY2UpIGZy
b20gY3JhZnRlZCBpbWFnZS4KCkZpeDogYWRkIGRlcHRoIGxpbWl0aW5nIGFuZCBjeWNsZSBkZXRl
Y3Rpb24gbWF0Y2hpbmcgdGhlIGV4aXN0aW5nCmZzY2suZXJvZnMgaW1wbGVtZW50YXRpb24sIG9y
IGNvbnZlcnQgdG8gaXRlcmF0aXZlIHRyYXZlcnNhbCB3aXRoCmFuIGV4cGxpY2l0IHN0YWNrLgo=
--00000000000007b76a0653ecec39--

