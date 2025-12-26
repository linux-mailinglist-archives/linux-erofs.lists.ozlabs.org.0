Return-Path: <linux-erofs+bounces-1616-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5412ACDEAEC
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Dec 2025 13:18:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dd4Qy4KTFz2yFQ;
	Fri, 26 Dec 2025 23:18:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766751530;
	cv=none; b=YvKkvb5hD4KlVajVD0WyhUx48fdeX8tyZf/TrHE+vQEpKQAGoOn1COxu/Cc25jCk4iE3Cp/wT6cc95iPRFQlu6aL3AM22hqHUMaUa5J+XZdMh2J6c4XMGHQCDdryrla1iicVX9GG8lJxQha9XWnLQl6IBQcJRfmY0j9mHvJzSe4dvHGBiw7RiZuOcAQ8xnv6GNF3Tzl1lhGKpvBn1e3apwwTBHAPlP1Rzj3U3rcTKBhpWRocevRMSjLn07oS9yunILiY4q5+tpozNixwERq6CKDCzfv1TH6Km+XWfQG5/UcQzfjX9SqdpMSaViYo9FXOsK4+wzDbJRW6Ltv7Ax7ZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766751530; c=relaxed/relaxed;
	bh=fDGOLtF0hV0DQgc2Rne2DbuXlP+UHpH52GIjNL6fTOg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DnUxSH6BN4A724M78mjESwJ0H7V03ii93SVl2vcRPqfLEJ6aC7PKYipSNxy2NW/YJca2ANMiQ0qBwG1vAM88827qFKm1yCw0f7D3aSWeO7Jz1Lh4IcWSktWDhsxGlIBsyC3EGFGMOmddzV/of2mMFEppb/dY8iLo9Ny8JysKzUEeX7THs97jrX/HCPU8M+TfzgC5sR9I6U06fr37/ukgRwz8KuVNrFxZaBMe6YDO1hU8kubsAG/75O4TURIlMCuPBr7HlSNRN363pjVdfsEkt3lBzzhtdNkDyUvY2uPP6hguKWwAfAx9y4U1Iq2CvgtkHGlK1wykuT0+BvFqG4qASw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=digitaltide.io; dkim=pass (2048-bit key; unprotected) header.d=itoolabs-com.20230601.gappssmtp.com header.i=@itoolabs-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=kXZXdr+y; dkim-atps=neutral; spf=pass (client-ip=209.85.208.46; helo=mail-ed1-f46.google.com; envelope-from=alexey.naidyonov@itoolabs.com; receiver=lists.ozlabs.org) smtp.mailfrom=itoolabs.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=digitaltide.io
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=itoolabs-com.20230601.gappssmtp.com header.i=@itoolabs-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=kXZXdr+y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=itoolabs.com (client-ip=209.85.208.46; helo=mail-ed1-f46.google.com; envelope-from=alexey.naidyonov@itoolabs.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dd4Qt6FMyz2xlM
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Dec 2025 23:18:35 +1100 (AEDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so8209587a12.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 26 Dec 2025 04:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itoolabs-com.20230601.gappssmtp.com; s=20230601; t=1766751451; x=1767356251; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fDGOLtF0hV0DQgc2Rne2DbuXlP+UHpH52GIjNL6fTOg=;
        b=kXZXdr+yo7PIDQIKUXFYVl9X32nVigb0xVjfhW19TTMLMyOuD+k6+9Ym5c9BxT8Pnu
         8rJL94ixkZH7JB68yO/1BgOmplOrVEnlS9vMPTyX/beIXrZmRwKs64UWDChASVL/cRb9
         kdFq90yERtM4NP8rnKf+0dqbSTs4gUDlY7yCSbbajrODbBQksWsJdvpmSIecjcx+swPq
         3N9QLNZj6xKLRXpR29SJZtw4AuUBTukmUClfTB+3i4o1ym3DfmNlt/efLMRFdYuvqR1a
         GfCwESvVXkW8Gk6HUvXK6fkhbP7k7PW0x4KVOCmW1fOrp017DqgtbSE/VRs6mtcZLa7z
         VIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766751451; x=1767356251;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDGOLtF0hV0DQgc2Rne2DbuXlP+UHpH52GIjNL6fTOg=;
        b=h5Wh+Y79BkEPI1pkf5Syou7fUjcl1RoNOsOdr6J7vChnYjOdjGnpq4k215ZU1vHNI0
         5YS6gY7y7vZj515T4KLEj3Qcfe+QjL5h+SDgmSvv7YoC35/Yq84PUlTpA6l13C0Q7Nw2
         /nJjhXKqyBqeiFhVteDBovEbbX3TUvrGNqdlOl5UG5ZiMUAa7+zHZEvIotpRt4XRTd9J
         HNO7Tqs+HFxY8imOjhKbJSAuDhFsKgBrE38pVT/uA44aItmxnfzu+pb/ulgBQ9903nQH
         OAQ5xDMY6IWZvR+A//0dYJ45h1qK5lH10iRb4fYYa7Sz1MAD6nYZXWiC4goxhySt+aDp
         oSWA==
X-Gm-Message-State: AOJu0YxycUTkMpYngGU9CLgq7ek9Pt0AaqxpOf9mm3MfOl4FfDPbNptv
	XtzG0sUPFpIM6/ZgbitFuZFf7Wh0n+5RXelWrxZsiHBqAMOGA+8z6ILNTAivf+TykhfPTJr5Dyw
	ojcKYtylXvh+CyMErgU90s71ixTJ+TWcpCejDtemjsuQ0gx/7bj4DG1g=
X-Gm-Gg: AY/fxX6ehHOksGt2Piy/Iwtqjbbg+8QUE+WO79RMgvdaNCT6rHCQdg8yJpnx99ewZKW
	whd/dp0nyghTRO5IPA9y0Wj0Ok4PoSUC53PCe3QxYkkanWiyI6mV9sK//nilCUmZ+3h+5qymHQl
	DNaKjx7t76TPDceADSOTve06NP9xZMdENSOASJ8zE78AOMbMQLMvdoR+AQRF8g3qh2i8M8tUqJF
	hOaacZd2WZ7e6w2z2KpS9Yqm0Dw5NBWY6tvbBk2r62UaPljTTXX3Py2IO8ldHABeFMcOTLZeDNW
	int7+74=
X-Google-Smtp-Source: AGHT+IFyrZ3sD9DtaMata9vN+lcYFYdtV1nj9VQdo3jz3GgEu1Kn5R3i5rsaacfPZLDKS76g0dDkSEv8GGyWz/jmh1M=
X-Received: by 2002:a05:6402:27c7:b0:64d:2822:cf71 with SMTP id
 4fb4d7f45d1cf-64d2822d2d5mr14641845a12.29.1766751450987; Fri, 26 Dec 2025
 04:17:30 -0800 (PST)
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
From: =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>
Date: Fri, 26 Dec 2025 13:17:15 +0100
X-Gm-Features: AQt7F2rzX12ABjFgudLlKSbu4PjmcnA1WOrWhADhzjQpAexbeLgzG_PIjtc3p7Y
Message-ID: <CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com>
Subject: [REGRESSION] erofs: new file-backed stacking limit breaks container
 overlay use case in 6.12.63
To: stable@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	xiang@kernel.org
Content-Type: multipart/alternative; boundary="000000000000a490780646d9e087"
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--000000000000a490780646d9e087
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am reporting a regression in the 6.12 stable series related to EROFS
file-backed mounts.

After updating from Linux 6.12.62 to 6.12.63, a previously working setup
using OSTree-backed composefs mounts as Podman rootfs no longer works.

The regression appears to be caused by the following commit:

  34447aeedbaea8f9aad3da5b07030a1c0e124639 ("erofs: limit the level of fs
stacking for file-backed mounts")
  (backport of upstream commit d53cd891f0e4311889349fff3a784dc552f814b9)

## Setup description

We use OSTree to materialize filesystem trees, which are mounted via
composefs (EROFS + overlayfs) as a read-only filesystem. This mounted
composefs tree is then used as a Podman rootfs, with Podman mounting a
writable overlayfs on top for each container.

This setup worked correctly on Linux 6.12.62 and earlier.

In short, the stacking looks like:

  EROFS (file-backed)
    -> composefs (EROFS + overlayfs with ostree repo as datadir, read-only)
        -> Podman rootfs overlays (RW upperdir)

There is no recursive or self-stacking of EROFS.

## Working case (6.12.62)

The composefs mount exists and Podman can successfully start a container
using it as rootfs.

Example composefs mount:

    =E2=9D=AF mount | grep
a31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c
    a31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c on
/home/growler/.local/share/containers/ostree/a31550cc69eef0e3227fa700623250=
592711fdfd51b5403a74288b55e89e7e8c
type overlay
(ro,noatime,lowerdir+=3D/proc/self/fd/10,datadir+=3D/proc/self/fd/7,redirec=
t_dir=3Don,metacopy=3Don)

(lowedir is a handle for the erofs file-backed mount, datadir is a handle
for the ostree repository objects directory)

Running Podman:

  =E2=9D=AF podman run --rm -it --rootfs
$HOME/.local/share/containers/ostree/a31550cc69eef0e3227fa700623250592711fd=
fd51b5403a74288b55e89e7e8c:O
bash -l
  root@d691e785bba3:/# uname -a
  Linux d691e785bba3 6.12.62 #1-NixOS SMP PREEMPT_DYNAMIC Fri Dec 12
17:37:22 UTC 2025 x86_64 GNU/Linux
  root@d691e785bba3:/#

(succeed)

## Failing case (6.12.63)

After upgrading to 6.12.63, the same command fails when Podman tries to
create the writable overlay on top of the composefs mount.

Error:

    =E2=9D=AF podman run --rm -it --rootfs
$HOME/.local/share/containers/ostree/a31550cc69eef0e3227fa700623250592711fd=
fd51b5403a74288b55e89e7e8c:O
bash -l
    Error: rootfs-overlay: creating overlay failed
"/home/growler/.local/share/containers/ostree/a31550cc69eef0e3227fa70062325=
0592711fdfd51b5403a74288b55e89e7e8c"
from native overlay: mount
overlay:/home/growler/.local/share/containers/storage/overlay-containers/a0=
851294d6b5b18062d4f5316032ee84d7bae700ea7d12c5be949d9e1999b0a1/rootfs/merge=
,
flags: 0x4, data:
lowerdir=3D/home/growler/.local/share/containers/ostree/a31550cc69eef0e3227=
fa700623250592711fdfd51b5403a74288b55e89e7e8c,upperdir=3D/home/growler/.loc=
al/share/containers/storage/overlay-containers/a0851294d6b5b18062d4f5316032=
ee84d7bae700ea7d12c5be949d9e1999b0a1/rootfs/upper,workdir=3D/home/growler/.=
local/share/containers/storage/overlay-containers/a0851294d6b5b18062d4f5316=
032ee84d7bae700ea7d12c5be949d9e1999b0a1/rootfs/work,userxattr:
invalid argument
    =E2=9D=AF uname -a
    Linux ci-node-09 6.12.63 #1-NixOS SMP PREEMPT_DYNAMIC Thu Dec 18
12:55:23 UTC 2025 x86_64 GNU/Linux

## Expected behavior

Using a composefs (EROFS + overlayfs) read-only mount as the lowerdir for a
container rootfs overlay should continue to work as it did in 6.12.62.

## Actual behavior

Overlayfs mounting fails with EINVAL when stacking on top of the composefs
mount backed by EROFS.

## Notes

The setup does not involve recursive EROFS mounting or unbounded stacking
depth. It appears the new stacking limit rejects this valid and previously
supported container use case.

Please let me know if further details or testing would be helpful.

Thank you,
--=20
 Aleks=C3=A9i Nad=C3=A9nov

--000000000000a490780646d9e087
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello,<br><br>I am reporting a regression=
 in the 6.12 stable series related to EROFS file-backed mounts.<br><br>Afte=
r updating from Linux 6.12.62 to 6.12.63, a previously working setup using =
OSTree-backed composefs mounts as Podman rootfs no longer works.<br><br>The=
 regression appears to be caused by the following commit:<br><br>=C2=A0 344=
47aeedbaea8f9aad3da5b07030a1c0e124639 (&quot;erofs: limit the level of fs s=
tacking for file-backed mounts&quot;)<br>=C2=A0 (backport of upstream commi=
t d53cd891f0e4311889349fff3a784dc552f814b9)<br><br>## Setup description<br>=
<br>We use OSTree to materialize filesystem trees, which are mounted via co=
mposefs (EROFS + overlayfs) as a read-only filesystem. This mounted compose=
fs tree is then used as a Podman rootfs, with Podman mounting a writable ov=
erlayfs on top for each container.<br><br>This setup worked correctly on Li=
nux 6.12.62 and earlier.<br><br>In short, the stacking looks like:<br><br>=
=C2=A0 EROFS (file-backed)<br>=C2=A0 =C2=A0 -&gt; composefs (EROFS + overla=
yfs with ostree repo as datadir, read-only)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
-&gt; Podman rootfs overlays (RW upperdir)<br><br>There is no recursive or =
self-stacking of EROFS.<br><br>## Working case (6.12.62)<br><br>The compose=
fs mount exists and Podman can successfully start a container using it as r=
ootfs.<br><br>Example composefs mount:<br><div><br></div><div>=C2=A0 =C2=A0=
=C2=A0=E2=9D=AF mount | grep a31550cc69eef0e3227fa700623250592711fdfd51b540=
3a74288b55e89e7e8c<br>=C2=A0 =C2=A0 a31550cc69eef0e3227fa700623250592711fdf=
d51b5403a74288b55e89e7e8c on /home/growler/.local/share/containers/ostree/a=
31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c type overla=
y (ro,noatime,lowerdir+=3D/proc/self/fd/10,datadir+=3D/proc/self/fd/7,redir=
ect_dir=3Don,metacopy=3Don)</div><div><br></div><div>(lowedir is a handle f=
or the erofs file-backed mount, datadir is a handle for the ostree reposito=
ry objects directory)</div><br>Running Podman:<br><br>=C2=A0=C2=A0=E2=9D=AF=
 podman run --rm -it --rootfs $HOME/.local/share/containers/ostree/a31550cc=
69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c:O bash -l<br>=C2=
=A0 root@d691e785bba3:/# uname -a<br>=C2=A0 Linux d691e785bba3 6.12.62 #1-N=
ixOS SMP PREEMPT_DYNAMIC Fri Dec 12 17:37:22 UTC 2025 x86_64 GNU/Linux<br>=
=C2=A0 root@d691e785bba3:/#=C2=A0<br><br></div><div>(succeed)</div><div dir=
=3D"ltr"><br>## Failing case (6.12.63)<br><br>After upgrading to 6.12.63, t=
he same command fails when Podman tries to create the writable overlay on t=
op of the composefs mount.<br><br>Error:<br><br>=C2=A0 =C2=A0 =E2=9D=AF pod=
man run --rm -it --rootfs $HOME/.local/share/containers/ostree/a31550cc69ee=
f0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c:O bash -l =C2=A0 =C2=
=A0<br>=C2=A0 =C2=A0 Error: rootfs-overlay: creating overlay failed &quot;/=
home/growler/.local/share/containers/ostree/a31550cc69eef0e3227fa7006232505=
92711fdfd51b5403a74288b55e89e7e8c&quot; from native overlay: mount overlay:=
/home/growler/.local/share/containers/storage/overlay-containers/a0851294d6=
b5b18062d4f5316032ee84d7bae700ea7d12c5be949d9e1999b0a1/rootfs/merge, flags:=
 0x4, data: lowerdir=3D/home/growler/.local/share/containers/ostree/a31550c=
c69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c,upperdir=3D/home/=
growler/.local/share/containers/storage/overlay-containers/a0851294d6b5b180=
62d4f5316032ee84d7bae700ea7d12c5be949d9e1999b0a1/rootfs/upper,workdir=3D/ho=
me/growler/.local/share/containers/storage/overlay-containers/a0851294d6b5b=
18062d4f5316032ee84d7bae700ea7d12c5be949d9e1999b0a1/rootfs/work,userxattr: =
invalid argument<br>=C2=A0 =C2=A0 =E2=9D=AF uname -a<br>=C2=A0 =C2=A0 Linux=
 ci-node-09 6.12.63 #1-NixOS SMP PREEMPT_DYNAMIC Thu Dec 18 12:55:23 UTC 20=
25 x86_64 GNU/Linux<br><br>## Expected behavior<br><br>Using a composefs (E=
ROFS + overlayfs) read-only mount as the lowerdir for a container rootfs ov=
erlay should continue to work as it did in 6.12.62.<br><br>## Actual behavi=
or<br><br>Overlayfs mounting fails with EINVAL when stacking on top of the =
composefs mount backed by EROFS.<br><br>## Notes<br><br>The setup does not =
involve recursive EROFS mounting or unbounded stacking depth. It appears th=
e new stacking limit rejects this valid and previously supported container =
use case.<br><br>Please let me know if further details or testing would be =
helpful.<br><br>Thank you,</div><div dir=3D"ltr">--=C2=A0</div><div>=C2=A0A=
leks=C3=A9i Nad=C3=A9nov</div>
</div>

--000000000000a490780646d9e087--

