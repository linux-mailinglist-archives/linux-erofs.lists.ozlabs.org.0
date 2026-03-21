Return-Path: <linux-erofs+bounces-2910-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jdfXL3mwvmmsXAMAu9opvQ
	(envelope-from <linux-erofs+bounces-2910-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 15:51:37 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CA02E5E6A
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 15:51:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdMnv4n7Vz2yZN;
	Sun, 22 Mar 2026 01:51:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::643" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774104691;
	cv=pass; b=BrB6bklplpFHBSriZ8mu3ysrFnztjJJsntkb1EiBlO7tlugToz3Z5RwDuXMkBAGvBHTXTIMRxkXRMTLRA3x2Z6cvtcSYsW+lgQ+xkpWixXy+zYM2Kp0Obh+Uzq7m6rdikItAJCNDK+USgn65w+d9svMsbILjFgK9Viwa3hGp3BHzo0C/Rv16MMsUXJd0KWrdIX88VviJkuqzKsHVVERkazTat/i7r8GC+hKI8bOqSWKXxubcVj++b7X0MipNOywcs9C5JZrvU8yAGSTqy7VPfysEjyNZ0Jkrc1UUw5413/2Qi4kWefcqJSFs+BPuC7rWGFitLkCI5FSFdg9Isbdv9A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774104691; c=relaxed/relaxed;
	bh=NuCAHJU+AqBns5GszCqWJyw95ZkDCbPZYpKkyZwR5cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cal3MsaaBIdRzXtQkqFxfSKPyv5qamQV5MpCn7L41PlHC8AX/L7mcsJgfMali05RGu1Dlj84izpTR/rOqNgCdPUAovAMmtKMyINl2b2VSsDZO65kHdhwdMMbjs8GgxBTLPUOyYerUJEEHo6yOM5vXwKXKYvuUeJP51/1nLvYRSL/kg3u+9K14PLSbT+cRL25+8qbULYA0HqFsDGat0q47FJGmm/qcZbEkiSV4oRjHpWdSkYoAupmyVlBJeWi9AZGG/PSfg7QHU7MGGllM1TqipygTzjGcKH1Fme/itP9RpmxAM6Oq9DinxFudkFOOmPITmwoFL9xnVNZSkFsIm8c7g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NcHIaEW7; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=kamranalam4555@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NcHIaEW7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=kamranalam4555@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdMnr6Kj9z2xWP
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 01:51:27 +1100 (AEDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-b9358dd7f79so253353666b.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 07:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774104679; cv=none;
        d=google.com; s=arc-20240605;
        b=OR4Rsiw6BHcBuR/jGpPeJ9JdgyRsb6TSkhfQqtGLaIN5mRB8vN9uU7T9Xpw8EcFbYx
         bGedcR7HB3ZLlIbnDonYzw1QtWCIJhhhdxs92xxrF72ANobI4kfSToGmV6wYSe7I9Drb
         cx1hJ0GsphBXwuWiSaKkxKDMKFnkeQX+yDKTuvluR3gOO/wna8PrnvmqAOBI6320lQWd
         DNyDx96mMLvuIGc71183Cbi5bZhS9H+4cbnoUhX63mHtXLR0wC84JpazTAawi5bhpBr0
         cAQ3pc+khVAg09Xgqqbe9hd0YatNy2StRvIGBmayozCp5I/OAWXRlw2Hx17zLnUH4kAS
         Y9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NuCAHJU+AqBns5GszCqWJyw95ZkDCbPZYpKkyZwR5cE=;
        fh=WJhIciIiNZdDmLC1ZQ8ngNos9wKcoX5v3UjHHDA3Xes=;
        b=KFsaAStcZxmCf1viXiZ6iQmer9YvXrw9rkWuduIVqP2T062mDJjzGV25o2CRgPQykL
         TV2/4frDtnbtCD/YMy6cBIcmc6tsPn7wMjL2zN39MB0c88OFi8HGKsKy5cK+hNLsGi1n
         P9yVkQJsuX7neoz8sUGLikd45Y+iAoFfks/3r5tiKFaDp4Z46VEqk80CLP7W7DLv9Oo1
         Wl1DJErI4uFj/iWD/szun/zjnHfI+dVEVIxXtsdbQtKv+hHTLjcSVKuGfFFj3Ajs8+o+
         AKaZCwOhmk+8ORbd6edudY+qjO4puedb8k8ac7wvNS1diFtFdCeu+fuuCFHGztAJcBwY
         xONQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774104679; x=1774709479; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NuCAHJU+AqBns5GszCqWJyw95ZkDCbPZYpKkyZwR5cE=;
        b=NcHIaEW7ybN6NEmGGjIF8Ji1RAj1LpBsk24JxvagJCE4OatkLgiklGiPFsYVi/mz7U
         7n7CPrdLPaQ9JgPXVPDSfEBdKMRShO3dOQXos8gpcO1USlDvA6XGK0ZyNVmCqBgHH5xC
         Gp3ce/hjpfdra8nJkgHZ/epwn3YbOUh/LReMsPJZgd1fW7hKEzBwTTS070ceVyRpzutC
         OguUGJi8316psmx7PBWpL7GL1yxG30XjBhTD4caepqTivEpbO5TpobNIEANr/huoRZtR
         gv8uO1+GZ3ChwF9/g0QVK1U2GKq8VWsi5yEgS3qfVoDnk5UV4NEO/9kCNUFpVKgqvTgH
         MGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774104679; x=1774709479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuCAHJU+AqBns5GszCqWJyw95ZkDCbPZYpKkyZwR5cE=;
        b=i48JAdSsIN/xhR9qFXfD8kvSQTiCucVWiFhnHdhoiVtHsqsbnvIhgfG3AixBwgA0s2
         +URMaJyige/GzcmacndgBL9rwhovWdU3yFW6wAMtWgONnAx1SV8eCYESj2Xr89tvUPj2
         6mr955UO6eojviOy+cVghfRI3Mkz6AD9iNX4qmCLKfGoAtIFG9Q9/Ii+Bk+ms1q+tZtf
         WV7M2+IlHu8KbIuUY2YWccvKwTygS3w8cQMZu16nBYx319B+wr3AQNS+Fw2XoqMyxh9V
         hjKwnMy16gW+7r0pFYUNHuDnOgQX3UUOtyGrclfwZdnOjYspRNZix/3QP47TgTFmaBW6
         Zk/g==
X-Gm-Message-State: AOJu0YyI9/yBDaF4XFwPemZrY71hX06udII+IjAxZSIP+v1wZm9eFli+
	y2hf0JEXldukwc8NQoUTL/QCdFNKddxuZ+sQfgZNMgWV29qqXKOVKN5I+rnopS1xsTS2ZxCJCKp
	t/8BgrtTcbGeGE5mbc25EAKPPTZyrtL+wl8FTQZE=
X-Gm-Gg: ATEYQzxYu5yI1RCC8PPyFusMx4FRoquxfXESkXBfcTc90IJ+4W0qNpuG2xkvBfdxYhO
	6vZgvpGJ4JLcMo6wpsVILTKBXV+dQpthh7j5ZZzPl7pBFzTvsFTAbR267Zkq/PSsHF34rXuACKd
	3rTrUg7begCMUbnH4wTh95E93UihzRR3pNslV5pV1oYLrjLPBWU6eBPo893OfJN4fINjXUbtOHc
	8g2CehD8SWL+t7A/oNlOHXzY96UxrS2hayukakOvE1jVGH5k7JH9m1PC1lH2YHxu6WFShYKqlWN
	TLk25wIHjn2F
X-Received: by 2002:a17:906:730b:b0:b98:3b5d:e148 with SMTP id
 a640c23a62f3a-b983b5df893mr396312566b.11.1774104679143; Sat, 21 Mar 2026
 07:51:19 -0700 (PDT)
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
References: <CAF7tac4iNk5msT0A6wOfuDHTSP1gcHx1xq20uiM9fy+A4GsdiA@mail.gmail.com>
 <85f0e47b-6554-4bbc-8167-336cfd522e6c@linux.alibaba.com>
In-Reply-To: <85f0e47b-6554-4bbc-8167-336cfd522e6c@linux.alibaba.com>
From: Kamran Alam <kamranalam4555@gmail.com>
Date: Sat, 21 Mar 2026 19:51:07 +0500
X-Gm-Features: AaiRm51f0flxzoK6rW18zzETm_chhr2uDSydBigMRuwD2a_UkzedA6kQamfoGAw
Message-ID: <CAF7tac72yg6VmocP7cqOMvYfEE2jH+9kYYuPARCQSM5tbmL7Cw@mail.gmail.com>
Subject: Re: [PATCH] ci: add workflow to mark tags as GitHub releases
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="00000000000031dd8d064d89ef52"
X-Spam-Status: No, score=1.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
	autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kamranalam4555@gmail.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2910-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kamranalam4555@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,v2:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 04CA02E5E6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000031dd8d064d89ef52
Content-Type: text/plain; charset="UTF-8"

>
> Thank you for the review, Gao Xiang.

I have updated the patch addressing all your feedback:

1. Added "erofs-utils:" prefix to subject
2. Extract release notes from ChangeLog file
3. Build static Linux binaries using Alpine/musl

---
 .github/workflows/release.yml | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/.github/workflows/release.yml b/.github/workflows/release.yml
new file mode 100644
--- /dev/null
+++ b/.github/workflows/release.yml
@@ -0,0 +1,121 @@
name: Release

on:
  push:
    tags:
      - "*"

permissions:
  contents: write

jobs:
  build-static-linux-musl:
    name: Build static Linux binaries (musl)
    runs-on: ubuntu-latest
    container:
      image: alpine:3.20

    steps:
      - name: Checkout source
        uses: actions/checkout@v4

      - name: Install build dependencies
        run: |
          apk add --no-cache \
            bash \
            build-base \
            autoconf \
            automake \
            libtool \
            lz4-dev \
            zlib-dev \
            fuse-dev \
            musl-dev \
            tar \
            gzip

      - name: Configure and build
        run: |
          ./autogen.sh
          ./configure --enable-static
          make -j"$(getconf _NPROCESSORS_ONLN || echo 2)"

      - name: Create release archive
        env:
          TAG_NAME: ${{ github.ref_name }}
        run: |
          set -e
          archive="erofs-utils-${TAG_NAME}-linux-musl-static.tar.gz"
          mkdir -p dist/bin
          for bin in \
            mkfs/mkfs.erofs \
            fsck/fsck.erofs \
            dump/dump.erofs \
            fuse/erofsfuse \
            mount/mount.erofs; do
            if [ -x "$bin" ]; then
              install -m 0755 "$bin" dist/bin/
            fi
          done
          tar -C dist -czf "$archive" .
          echo "archive=$archive" >> "$GITHUB_OUTPUT"
        id: package

      - name: Upload build artifact
        uses: actions/upload-artifact@v4
        with:
          name: static-linux-musl
          path: ${{ steps.package.outputs.archive }}

  release:
    name: Publish release
    runs-on: ubuntu-latest
    needs: build-static-linux-musl

    steps:
      - name: Checkout source
        uses: actions/checkout@v4

      - name: Download build artifact
        uses: actions/download-artifact@v4
        with:
          name: static-linux-musl
          path: .

      - name: Extract release notes from ChangeLog
        id: changelog
        shell: bash
        run: |
          tag_version="${GITHUB_REF_NAME#v}"
          notes_file="$(mktemp)"

          awk -v ver="$tag_version" '
            $0 ~ "^erofs-utils " {
              if (capture) exit
              if ($0 ~ "^erofs-utils " ver "([[:space:]]|$|\\()") {
                capture=1
                next
              }
            }
            capture && /^ -- / { exit }
            capture { print }
          ' ChangeLog > "$notes_file"

          sed -i '/^[[:space:]]*$/N;/^\n$/D' "$notes_file"

          if [ ! -s "$notes_file" ]; then
            echo "No matching changelog entry found for
${GITHUB_REF_NAME}." > "$notes_file"
          fi

          {
            echo "body<<EOF"
            cat "$notes_file"
            echo "EOF"
          } >> "$GITHUB_OUTPUT"

      - name: Create GitHub release
        uses: softprops/action-gh-release@v2
        with:
          name: ${{ github.ref_name }}
          body: ${{ steps.changelog.outputs.body }}
          files: erofs-utils-${{ github.ref_name }}-linux-musl-static.tar.gz


Signed-off-by: Kamran Alam <kamrankhan0368@gmail.com>

--00000000000031dd8d064d89ef52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"></blockquote>Thank you for the rev=
iew, Gao Xiang.<br><br>I have updated the patch addressing all your feedbac=
k:<br><br>1. Added &quot;erofs-utils:&quot; prefix to subject<br>2. Extract=
 release notes from ChangeLog file<br>3. Build static Linux binaries using =
Alpine/musl<br><br>---<br>=C2=A0.github/workflows/release.yml | 121 +++++++=
++++++++++++++<br>=C2=A01 file changed, 121 insertions(+)<br><br>diff --git=
 a/.github/workflows/release.yml b/.github/workflows/release.yml<br>new fil=
e mode 100644<br>--- /dev/null<br>+++ b/.github/workflows/release.yml<br>@@=
 -0,0 +1,121 @@<br><div style=3D"color:rgb(228,228,228);background-color:rg=
b(24,24,24);font-family:Consolas,&quot;Courier New&quot;,monospace;font-siz=
e:14px;line-height:19px;white-space:pre"><div><span style=3D"color:rgb(227,=
148,220)">name</span>: <span style=3D"color:rgb(227,148,220)">Release</span=
></div><br><div><span style=3D"color:rgb(227,148,220)">on</span>:</div><div=
>=C2=A0 <span style=3D"color:rgb(227,148,220)">push</span>:</div><div>=C2=
=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">tags</span>:</div><div>=
=C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(214,214,221)">-</span> <span =
style=3D"color:rgb(227,148,220)">&quot;*&quot;</span></div><br><div><span s=
tyle=3D"color:rgb(227,148,220)">permissions</span>:</div><div>=C2=A0 <span =
style=3D"color:rgb(227,148,220)">contents</span>: <span style=3D"color:rgb(=
227,148,220)">write</span></div><br><div><span style=3D"color:rgb(227,148,2=
20)">jobs</span>:</div><div>=C2=A0 <span style=3D"color:rgb(227,148,220)">b=
uild-static-linux-musl</span>:</div><div>=C2=A0 =C2=A0 <span style=3D"color=
:rgb(227,148,220)">name</span>: <span style=3D"color:rgb(227,148,220)">Buil=
d static Linux binaries (musl)</span></div><div>=C2=A0 =C2=A0 <span style=
=3D"color:rgb(227,148,220)">runs-on</span>: <span style=3D"color:rgb(227,14=
8,220)">ubuntu-latest</span></div><div>=C2=A0 =C2=A0 <span style=3D"color:r=
gb(227,148,220)">container</span>:</div><div>=C2=A0 =C2=A0 =C2=A0 <span sty=
le=3D"color:rgb(227,148,220)">image</span>: <span style=3D"color:rgb(227,14=
8,220)">alpine:3.20</span></div><br><div>=C2=A0 =C2=A0 <span style=3D"color=
:rgb(227,148,220)">steps</span>:</div><div>=C2=A0 =C2=A0 =C2=A0 <span style=
=3D"color:rgb(214,214,221)">-</span> <span style=3D"color:rgb(227,148,220)"=
>name</span>: <span style=3D"color:rgb(227,148,220)">Checkout source</span>=
</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220=
)">uses</span>: <span style=3D"color:rgb(227,148,220)">actions/checkout@v4<=
/span></div><br><div>=C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(214,214,=
221)">-</span> <span style=3D"color:rgb(227,148,220)">name</span>: <span st=
yle=3D"color:rgb(227,148,220)">Install build dependencies</span></div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">run</spa=
n>: <span style=3D"color:rgb(130,210,206)">|</span></div><div>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">apk add --no-c=
ache \</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rg=
b(227,148,220)">=C2=A0 =C2=A0 bash \</span></div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 =C2=A0 build-base \</s=
pan></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148=
,220)">=C2=A0 =C2=A0 autoconf \</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 =C2=A0 automake \</span><=
/div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)=
">=C2=A0 =C2=A0 libtool \</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <spa=
n style=3D"color:rgb(227,148,220)">=C2=A0 =C2=A0 lz4-dev \</span></div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 =
=C2=A0 zlib-dev \</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=
=3D"color:rgb(227,148,220)">=C2=A0 =C2=A0 fuse-dev \</span></div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 =C2=
=A0 musl-dev \</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"=
color:rgb(227,148,220)">=C2=A0 =C2=A0 tar \</span></div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 =C2=A0 gzip</sp=
an></div><br><div>=C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(214,214,221=
)">-</span> <span style=3D"color:rgb(227,148,220)">name</span>: <span style=
=3D"color:rgb(227,148,220)">Configure and build</span></div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">run</span>: <span =
style=3D"color:rgb(130,210,206)">|</span></div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">./autogen.sh</span></d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=
=C2=A0 ./configure --enable-static</span></div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 make -j&quot;$(getconf=
 _NPROCESSORS_ONLN || echo 2)&quot;</span></div><br><div>=C2=A0 =C2=A0 =C2=
=A0 <span style=3D"color:rgb(214,214,221)">-</span> <span style=3D"color:rg=
b(227,148,220)">name</span>: <span style=3D"color:rgb(227,148,220)">Create =
release archive</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D=
"color:rgb(227,148,220)">env</span>:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <span style=3D"color:rgb(227,148,220)">TAG_NAME</span>: <span style=
=3D"color:rgb(227,148,220)">${{ github.ref_name }}</span></div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">run</span>: <sp=
an style=3D"color:rgb(130,210,206)">|</span></div><div>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">set -e</span></div><d=
iv>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=
=A0 archive=3D&quot;erofs-utils-${TAG_NAME}-linux-musl-static.tar.gz&quot;<=
/span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,1=
48,220)">=C2=A0 mkdir -p dist/bin</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 for bin in \</span></div>=
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=
=A0 =C2=A0 mkfs/mkfs.erofs \</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
span style=3D"color:rgb(227,148,220)">=C2=A0 =C2=A0 fsck/fsck.erofs \</span=
></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,22=
0)">=C2=A0 =C2=A0 dump/dump.erofs \</span></div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 =C2=A0 fuse/erofsfuse =
\</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227=
,148,220)">=C2=A0 =C2=A0 mount/mount.erofs; do</span></div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 =C2=A0 if [=
 -x &quot;$bin&quot; ]; then</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
span style=3D"color:rgb(227,148,220)">=C2=A0 =C2=A0 =C2=A0 install -m 0755 =
&quot;$bin&quot; dist/bin/</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <sp=
an style=3D"color:rgb(227,148,220)">=C2=A0 =C2=A0 fi</span></div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 done=
</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,=
148,220)">=C2=A0 tar -C dist -czf &quot;$archive&quot; .</span></div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 e=
cho &quot;archive=3D$archive&quot; &gt;&gt; &quot;$GITHUB_OUTPUT&quot;</spa=
n></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,2=
20)">id</span>: <span style=3D"color:rgb(227,148,220)">package</span></div>=
<br><div>=C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(214,214,221)">-</spa=
n> <span style=3D"color:rgb(227,148,220)">name</span>: <span style=3D"color=
:rgb(227,148,220)">Upload build artifact</span></div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">uses</span>: <span style=
=3D"color:rgb(227,148,220)">actions/upload-artifact@v4</span></div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">with</span>=
:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227=
,148,220)">name</span>: <span style=3D"color:rgb(227,148,220)">static-linux=
-musl</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"co=
lor:rgb(227,148,220)">path</span>: <span style=3D"color:rgb(227,148,220)">$=
{{ steps.package.outputs.archive }}</span></div><br><div>=C2=A0 <span style=
=3D"color:rgb(227,148,220)">release</span>:</div><div>=C2=A0 =C2=A0 <span s=
tyle=3D"color:rgb(227,148,220)">name</span>: <span style=3D"color:rgb(227,1=
48,220)">Publish release</span></div><div>=C2=A0 =C2=A0 <span style=3D"colo=
r:rgb(227,148,220)">runs-on</span>: <span style=3D"color:rgb(227,148,220)">=
ubuntu-latest</span></div><div>=C2=A0 =C2=A0 <span style=3D"color:rgb(227,1=
48,220)">needs</span>: <span style=3D"color:rgb(227,148,220)">build-static-=
linux-musl</span></div><br><div>=C2=A0 =C2=A0 <span style=3D"color:rgb(227,=
148,220)">steps</span>:</div><div>=C2=A0 =C2=A0 =C2=A0 <span style=3D"color=
:rgb(214,214,221)">-</span> <span style=3D"color:rgb(227,148,220)">name</sp=
an>: <span style=3D"color:rgb(227,148,220)">Checkout source</span></div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">uses</=
span>: <span style=3D"color:rgb(227,148,220)">actions/checkout@v4</span></d=
iv><br><div>=C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(214,214,221)">-</=
span> <span style=3D"color:rgb(227,148,220)">name</span>: <span style=3D"co=
lor:rgb(227,148,220)">Download build artifact</span></div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">uses</span>: <span=
 style=3D"color:rgb(227,148,220)">actions/download-artifact@v4</span></div>=
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">wit=
h</span>:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color=
:rgb(227,148,220)">name</span>: <span style=3D"color:rgb(227,148,220)">stat=
ic-linux-musl</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <span sty=
le=3D"color:rgb(227,148,220)">path</span>: <span style=3D"color:rgb(227,148=
,220)">.</span></div><br><div>=C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb=
(214,214,221)">-</span> <span style=3D"color:rgb(227,148,220)">name</span>:=
 <span style=3D"color:rgb(227,148,220)">Extract release notes from ChangeLo=
g</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227=
,148,220)">id</span>: <span style=3D"color:rgb(227,148,220)">changelog</spa=
n></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,2=
20)">shell</span>: <span style=3D"color:rgb(227,148,220)">bash</span></div>=
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">run=
</span>: <span style=3D"color:rgb(130,210,206)">|</span></div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">tag_vers=
ion=3D&quot;${GITHUB_REF_NAME#v}&quot;</span></div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 notes_file=3D&quot=
;$(mktemp)&quot;</span></div><br><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span sty=
le=3D"color:rgb(227,148,220)">=C2=A0 awk -v ver=3D&quot;$tag_version&quot; =
&#39;</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb=
(227,148,220)">=C2=A0 =C2=A0 $0 ~ &quot;^erofs-utils &quot; {</span></div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=
=A0 =C2=A0 =C2=A0 if (capture) exit</span></div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 =C2=A0 =C2=A0 if ($0 ~=
 &quot;^erofs-utils &quot; ver &quot;([[:space:]]|$|\\()&quot;) {</span></d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 capture=3D1</span></div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 next</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:=
rgb(227,148,220)">=C2=A0 =C2=A0 =C2=A0 }</span></div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 =C2=A0 }</span></d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=
=C2=A0 =C2=A0 capture &amp;&amp; /^ -- / { exit }</span></div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 =C2=A0 c=
apture { print }</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=
=3D"color:rgb(227,148,220)">=C2=A0 &#39; ChangeLog &gt; &quot;$notes_file&q=
uot;</span></div><br><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:=
rgb(227,148,220)">=C2=A0 sed -i &#39;/^[[:space:]]*$/N;/^\n$/D&#39; &quot;$=
notes_file&quot;</span></div><br><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span sty=
le=3D"color:rgb(227,148,220)">=C2=A0 if [ ! -s &quot;$notes_file&quot; ]; t=
hen</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(2=
27,148,220)">=C2=A0 =C2=A0 echo &quot;No matching changelog entry found for=
 ${GITHUB_REF_NAME}.&quot; &gt; &quot;$notes_file&quot;</span></div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 f=
i</span></div><br><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb=
(227,148,220)">=C2=A0 {</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span =
style=3D"color:rgb(227,148,220)">=C2=A0 =C2=A0 echo &quot;body&lt;&lt;EOF&q=
uot;</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(=
227,148,220)">=C2=A0 =C2=A0 cat &quot;$notes_file&quot;</span></div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">=C2=A0 =
=C2=A0 echo &quot;EOF&quot;</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <s=
pan style=3D"color:rgb(227,148,220)">=C2=A0 } &gt;&gt; &quot;$GITHUB_OUTPUT=
&quot;</span></div><br><div>=C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(2=
14,214,221)">-</span> <span style=3D"color:rgb(227,148,220)">name</span>: <=
span style=3D"color:rgb(227,148,220)">Create GitHub release</span></div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">uses</=
span>: <span style=3D"color:rgb(227,148,220)">softprops/action-gh-release@v=
2</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227=
,148,220)">with</span>:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <span =
style=3D"color:rgb(227,148,220)">name</span>: <span style=3D"color:rgb(227,=
148,220)">${{ github.ref_name }}</span></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <span style=3D"color:rgb(227,148,220)">body</span>: <span style=
=3D"color:rgb(227,148,220)">${{ steps.changelog.outputs.body }}</span></div=
><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(227,148,2=
20)">files</span>: <span style=3D"color:rgb(227,148,220)">erofs-utils-${{ g=
ithub.ref_name }}-linux-musl-static.tar.gz</span></div><br></div><br>Signed=
-off-by: Kamran Alam &lt;<a href=3D"mailto:kamrankhan0368@gmail.com">kamran=
khan0368@gmail.com</a>&gt;</div></div>

--00000000000031dd8d064d89ef52--

