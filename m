Return-Path: <linux-erofs+bounces-2918-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEfbBtXVvmlwewMAu9opvQ
	(envelope-from <linux-erofs+bounces-2918-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 18:31:01 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F5D2E68C0
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 18:30:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdRKr1WTGz2ygG;
	Sun, 22 Mar 2026 04:30:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b12c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774114256;
	cv=pass; b=UOLsCkNkj/zh8iG8KTtUo9O2Ci8P2uX5kbJpNNnn5GTfrfnk7xRLbtwqfF9d4YmhJ4t4MP56VhCSD/hDo6g4oZ59O8hrSHLaEIfl30Pn6//2YW7p0Tu0yR0+cZrwO+YQ1G5yOPEjTFn05wksYpgMZePeeibOrcs1roDL+u0Q3co4LCRZWZMBoLRbJr/KoM+PzDZ8fH3uJ8X9WwcjmFrCwtsAtUXQKfiZjO/yqHFF4N8/BO/8PxnlmZuqyiT8HA7uS/ulDNrvW488vXYI0YQbUAKs/jJmmOB4xaqq9dt6LSu31AD8+lVPBBAShJOurrEHZHZLt3ahriVFm+HtxAjiKg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774114256; c=relaxed/relaxed;
	bh=P763h9nqu3D+dZuH8Gk5JP9qRSqi1+tHscJlUlRtZpo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ArrXt5JhErQa5/iyeH650sBMD06840Q25vOURnoCBh9nQRJqI7IhB8ZM0cIfB4DpXMz71fEjvHB6Sk8Np9XqvRh806B0Few01f9MHWeW8VcMdRz5Ua+/zuTtda+JJ6aQIOZwd+2+ppr7pmXnKUXoXdOgikiO60GyPdEWq4dtyJVyeV/WXBm2kj3F7nw7lSgCG7IcoilfLju2X2JY8VZJh8HrtyGBDn/gAySge1w0UKWdA3t0vQeEzR5rPD+fXHKLTA7PUyNiwPUNS2iFZFhXVGwnjQYtp22SR7Ntaj9ydYVdKRvY7yJNYO+vsTwD9iCOYPNiSLHsJ1/oPb8WJJJrhw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=e8EeL39e; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com; envelope-from=shailesh91199477@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=e8EeL39e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com; envelope-from=shailesh91199477@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com [IPv6:2607:f8b0:4864:20::b12c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdRKp1VQ5z2yYq
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 04:30:53 +1100 (AEDT)
Received: by mail-yx1-xb12c.google.com with SMTP id 956f58d0204a3-64ad79dfb6eso3901510d50.0
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 10:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774114250; cv=none;
        d=google.com; s=arc-20240605;
        b=XTuKsDhFQbcauZpv2HGgfyJJP5oSZJFXFHXLQ4oMMtu2nD7JHDIuomMEZHXVSKZqMv
         4jgyBNgpDB+ErulJPaWhRbcgXEcPnxZYHkagSaY8YEzvna0MyJjt3SiHdlE2qa/Xe82d
         kls/vpBzRSAKgyAXcDTbWgxC8Kv7Pvmzigf0XMoRARK+QuAaZ3OitoXvUzgvrKHHgPzV
         P6q2ytNImOBlmE6/ahO0RaB5pBR+1CuCldvXVPgSl5c6vdhEeImOs5mZKFKFZUD7QgWm
         6Qw7Qz0cSvWRp1Fz96tQ8/33bXTAzrxRX9+SzzytghfUryVWWTpgAJ7BtXoMDAklHmJf
         RfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=P763h9nqu3D+dZuH8Gk5JP9qRSqi1+tHscJlUlRtZpo=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=VhsZiWOvJcxcqm7w4z7zPRsavTrhDUwN9r4cXYZfh/NE0Q48y/eYxhYs3IjHCNjPHK
         bx0v9sLQoGU1KNP12OE+5llJbT9ZDwsyrwVFHvPH5x+dsOCyriHZOIep22FLXqEtzk46
         ezFJ6H7waIxAtAD3Fpr0ppHxtvd4xd1kzCqhRz8HaY01kiw9U/SzA2vBlJoilc0pcgLy
         6rJxabi6A/kFV1nR5pAoxzbrXssNFHAI3KFa/F3aM7h+Kk0Nx3nc5gDW/uhYwM9f0Sri
         bmrQoHFKlFmtgnuKJYIIaG5OhrBe1Gt9UULV5XY43ejNIK77SX6QZqGisc9uWAxd8bJN
         MlBg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774114250; x=1774719050; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P763h9nqu3D+dZuH8Gk5JP9qRSqi1+tHscJlUlRtZpo=;
        b=e8EeL39e++yiM/kHJVaugeq7pYBKMksmG8cXW6v8HIOUPCNDjOzklkRiXgLgXouKMv
         5yp/H6EfSIjUXLqckMKGSIkMXWW+uDRSb8VfH3JZT7SW4HG0Q68Xcy/zZ4Itu2uZIC3z
         wGelAnOhe3NNOjKvULw7D98Gi3viX7g+IgUGR1nzcfuHbealpLhaVYx9iiIRVh7ieBX4
         vozKgs9B/bnUw7enyDIlQqXWiasu4WBqP84q3y5ugQNKoxKPF2nnlf4iQFsoqWC8iv0a
         brhkBzTTah7ZpvdcGcNkUGqJptv8MM0KvuKyuUOC24d3qSd0OjoRMHPLnlmML48+RZIz
         JxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774114250; x=1774719050;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P763h9nqu3D+dZuH8Gk5JP9qRSqi1+tHscJlUlRtZpo=;
        b=ZOHhLWSjRx5LZr6bNZsTUAzU5a6Naqz3y/4C05s884IJCNM7HHn9jeEjlE92+Z63zv
         KFmntvq2fgvq/64zJN0oIQP4M5M+MDGqWlGRTOh6UHUX+wmzNJjgfVYYNYBwhOE0yV4k
         NrWepOfAeBy7I8nRtU03ycdbjWQV9A0AvsebCsAncbTOHJ5b6m8lrYu/yMjrlLAQNsCG
         vy6Fn6m3+k3SgfCwo+UGmYfOJhaa0reSpwOw71/MS1HkBaUOn/2UQ7BVqOSd2dI1fZQ9
         y5ePW2OYaSAXLyQ76ki6iXAADsj7heYz/0Pf/rRvXF7u3wEwq3rVrmSS20tp2D/8sRgT
         xjKg==
X-Gm-Message-State: AOJu0YwHZFaQ0i92RVsLQZ7e8Iwq07I6I49uR6gQHqasoVfEfidSq15a
	3bp5nt8KRuJk94+sX/sCVRqk0G+HdUIN1+0girihW/Dgk4XYFnEwqKe3+IAdlSiIrVH0C3zCJUJ
	ARCS3xZwQ5iveQEh5B8Af+DXWDkGgVKeXa0CSwuOpDQ==
X-Gm-Gg: ATEYQzwYS7AIb2m11hQSOgoDV97cQUjzuZQ5X9RjO/8FiZpjqtWu671ywVEW1lBBLT4
	d42T4J5qpUnyVuFBomJEmlEfRSDsftwMnTP/9q6iHXXE8f50OiPH8aVkcuKA+w4vvIX7bw2tMfs
	9M3oJIQUe46L1XG95Oau5GrK1z1TnFYZ0/CPz671eONWcb9IZy4ESmTQDLfHThyWC5PadqdtEmk
	EdP6PhZXmRGyTrWJYKbmu2AJo8F6uteVw+pJdRN0rtsOvzlx3BGfZbiKFersg9ZRGQDNpenymQ/
	l7z6CA3XkxCi1GSKu+WULZefDoFQhCr6hlCf3XsEsyquEZTmrdDINUEfrEVy1Bo0C4fk6vdqvg=
	=
X-Received: by 2002:a53:ec0c:0:b0:64a:e0fc:1a70 with SMTP id
 956f58d0204a3-64eaa7ff989mr5817643d50.63.1774114249989; Sat, 21 Mar 2026
 10:30:49 -0700 (PDT)
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
From: Shailesh Kumar <shailesh91199477@gmail.com>
Date: Sat, 21 Mar 2026 23:00:38 +0530
X-Gm-Features: AaiRm508OFE9GJ-5mykmPNCTANcL0bqVWuG_XYDfQtpp2ZzAYC7knWf6jsJRaUk
Message-ID: <CAEUOX7QcBcGXsV1xCTm5eqx=kawq7oTx=S+FRrFhm1PqZmLZcg@mail.gmail.com>
Subject: [GSoC 2026][Discussion] mkfs.erofs: manifest-based filesystem
 generation support
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000a96461064d8c2960"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2918-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.900];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shailesh91199477@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 29F5D2E68C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000a96461064d8c2960
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am Shailesh Kumar, a CSE student preparing a GSoC 2026 proposal for
erofs-utils.

I have been going through the mkfs.erofs codebase, particularly
mkfs/main.c, lib/inode.c, and the current directory/tar input pipeline, to
understand how inodes are constructed and passed to the layout and write
stages.

My proposal is to add support for generating EROFS images from manifest
files (composefs-dump and BSD mtree), instead of relying only on source
directories or tarballs.

The idea is to introduce a new --manifest option, where:
- manifest files describe the filesystem tree (paths, metadata, file types)
- file contents are resolved using a separate data directory (--data-dir)
- parsed entries are converted into erofs_inode structures
- the existing layout and write pipeline (lib/compress.c, lib/super.c)
remains unchanged

A simplified flow would be:

    manifest file =E2=86=92 parser =E2=86=92 manifest entries =E2=86=92 ino=
de construction =E2=86=92
existing pipeline =E2=86=92 image

I plan to:
- add a manifest parsing layer (lib/manifest.c)
- implement parsers for composefs-dump and BSD mtree formats
- reuse existing inode construction logic instead of stat()-based directory
scanning

Before finalizing the design, I wanted to confirm a few points:

1. Is introducing a separate manifest parsing layer (lib/manifest.c)
aligned with the current structure, or would integration into existing
inode paths be preferred?

2. For composefs-dump, is resolving file data via --data-dir/<digest> an
acceptable approach?

3. For BSD mtree, is it reasonable to start with a common subset of
keywords (type, uid, gid, mode, size, link, device) and expand later if
needed?

4. Are there preferred conventions or locations for adding new mkfs.erofs
tests?

I would really appreciate any feedback on whether this approach aligns with
the project expectations, or if there are specific constraints I should
consider before implementation.

Thanks for your time.

Best regards,
Shailesh Kumar
GitHub: https://github.com/SKM2227229725

--000000000000a96461064d8c2960
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>I am Shailesh Kumar, a CSE student preparing=
 a GSoC 2026 proposal for erofs-utils.<br><br>I have been going through the=
 mkfs.erofs codebase, particularly mkfs/main.c, lib/inode.c, and the curren=
t directory/tar input pipeline, to understand how inodes are constructed an=
d passed to the layout and write stages.<br><br>My proposal is to add suppo=
rt for generating EROFS images from manifest files (composefs-dump and BSD =
mtree), instead of relying only on source directories or tarballs.<br><br>T=
he idea is to introduce a new --manifest option, where:<br>- manifest files=
 describe the filesystem tree (paths, metadata, file types)<br>- file conte=
nts are resolved using a separate data directory (--data-dir)<br>- parsed e=
ntries are converted into erofs_inode structures<br>- the existing layout a=
nd write pipeline (lib/compress.c, lib/super.c) remains unchanged<br><br>A =
simplified flow would be:<br><br>=C2=A0 =C2=A0 manifest file =E2=86=92 pars=
er =E2=86=92 manifest entries =E2=86=92 inode construction =E2=86=92 existi=
ng pipeline =E2=86=92 image<br><br>I plan to:<br>- add a manifest parsing l=
ayer (lib/manifest.c)<br>- implement parsers for composefs-dump and BSD mtr=
ee formats<br>- reuse existing inode construction logic instead of stat()-b=
ased directory scanning<br><br>Before finalizing the design, I wanted to co=
nfirm a few points:<br><br>1. Is introducing a separate manifest parsing la=
yer (lib/manifest.c) aligned with the current structure, or would integrati=
on into existing inode paths be preferred?<br><br>2. For composefs-dump, is=
 resolving file data via --data-dir/&lt;digest&gt; an acceptable approach?<=
br><br>3. For BSD mtree, is it reasonable to start with a common subset of =
keywords (type, uid, gid, mode, size, link, device) and expand later if nee=
ded?<br><br>4. Are there preferred conventions or locations for adding new =
mkfs.erofs tests?<br><br>I would really appreciate any feedback on whether =
this approach aligns with the project expectations, or if there are specifi=
c constraints I should consider before implementation.<br><br>Thanks for yo=
ur time.<br><br>Best regards, =C2=A0<br>Shailesh Kumar =C2=A0<br>GitHub: <a=
 href=3D"https://github.com/SKM2227229725">https://github.com/SKM2227229725=
</a></div>

--000000000000a96461064d8c2960--

