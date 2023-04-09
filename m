Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E0C6DBFBF
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 14:02:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvW1q30SCz3cf0
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 22:02:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.a=rsa-sha256 header.s=202211 header.b=UqF+oRGZ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabijaczleweli.xyz (client-ip=139.28.40.42; helo=tarta.nabijaczleweli.xyz; envelope-from=nabijaczleweli@nabijaczleweli.xyz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.a=rsa-sha256 header.s=202211 header.b=UqF+oRGZ;
	dkim-atps=neutral
X-Greylist: delayed 355 seconds by postgrey-1.36 at boromir; Sun, 09 Apr 2023 22:02:19 AEST
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvW1l2s6Jz3cd5
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Apr 2023 22:02:18 +1000 (AEST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 17C8354FA
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Apr 2023 13:56:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202211; t=1681041380;
	bh=umApZmLDhmUeRGR/nSmwPJr8wXmhWa8eAXMXxNv+TJc=;
	h=Date:From:Cc:Subject:From;
	b=UqF+oRGZzDANJtIIycNm/ataXSwcgZrs1dSaitB1LiKlb5nDGnVFtBm6rj1GN8rg2
	 c+j8nToslhcvvwwkoIwlQ54WttRaAmsfk6VWd6ba8OQ9/lNocvqba/wsaHeVsoiF/F
	 oOA/YKPChdVKHul38gOe63vBK6VTSRuh2Afr+RUB02+CDdxYqfq2+W5CpEaXqQATIE
	 XKszNXHe4R1Cqgo+GdG9z5ZMS0lr/zLhFMhhTkyJsQfSL6ALg12jfzxADba5YiUkiQ
	 Nwwn5a7KnwZLzmQrXEaqDMaS0IIwqlMc1hDcNN5/ofmp6UmyzNvrSju7FuSSd/MdtB
	 W/wDOwY7hoKMw==
Date: Sun, 9 Apr 2023 13:56:18 +0200
From: 	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Subject: [PATCH 1/5] erofs-utils: lib: rb_tree: fix broken rb_iter_init()
 prototype
Message-ID: <d80484200b3ba60127ff3b92e0c7660a2e8726bf.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5v5ks5oi6zrb3jo2"
Content-Disposition: inline
User-Agent: NeoMutt/20230407
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--5v5ks5oi6zrb3jo2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In file included from rb_tree.c:34:
=2E/rb_tree.h:96:17: warning: a function declaration without a prototype
is deprecated in all versions of C and is treated as a zero-parameter
prototype in C2x, conflicting with a subsequent definition
[-Wdeprecated-non-prototype]
struct rb_iter *rb_iter_init            ();
                ^
rb_tree.c:422:1: note: conflicting prototype is here
rb_iter_init (struct rb_iter *self) {
^

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 lib/rb_tree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rb_tree.h b/lib/rb_tree.h
index 5b35c74..67ec0a7 100644
--- a/lib/rb_tree.h
+++ b/lib/rb_tree.h
@@ -93,7 +93,7 @@ int             rb_tree_remove_with_cb  (struct rb_tree *=
self, void *value, rb_t
 int             rb_tree_test            (struct rb_tree *self, struct rb_n=
ode *root);
=20
 struct rb_iter *rb_iter_alloc           ();
-struct rb_iter *rb_iter_init            ();
+struct rb_iter *rb_iter_init            (struct rb_iter *self);
 struct rb_iter *rb_iter_create          ();
 void            rb_iter_dealloc         (struct rb_iter *self);
 void           *rb_iter_first           (struct rb_iter *self, struct rb_t=
ree *tree);
--=20
2.30.2


--5v5ks5oi6zrb3jo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmQyp+IACgkQvP0LAY0m
WPHNcg//TOqE9HxkawcFB7liGxrkP6E+wt6/l0MHitdFRAX8CfbevoykEbfS9taL
uC1ZAALlUDdTrsT8uRuPGWhTBkToXza+0xqU2ouIVSRtnHccp1DsZe9RG/v3xxQc
HYMdpX7YGLTU7vZN2KINYKX+2j1Yn7f5JAI5Q5pnlOAbc9AXexJQ8K3nx037Mkgt
8FWlNKFJuxycd+g0GwlIPclcnmz54Yx8Dc/K9RvveYdBlWHl0T8zpqx1YWxJ4BIP
fIVvo7KifP28cwE7Pe6PtbOr8t3Quxjb7wU5qMep4SM+jJWfdJ4VIKy7obUxyawx
qOGxMWUHP94Q0o4QTYF4nEuudpUb8FoKhk+jmI33oWDw0AirLpJz/572fS+6ZBLn
wGEK+tchvDc6LzZ4woNi8p4egLg6m+/7StmTGNhnbTdw7wimSOGtXtkQrrWMvOwj
L8C+3jyo6Aze1S1rnrx0y1BdepXwkKyiIOSC474tepwCI3yz98fqnqcz3ox5KImf
ICOhQMfZauZecKX0f6Qc2jA7OuRPNfQQD6grrhnFeUvY426XJa9ohHPusEw9qIL+
TqhZYwTTAEDOckcX6p8jK5QN07afLiOGIjEYL7+4smg7FHlWv3eZF3RJ5ltZNJCg
6wM9UeKItn+T8qevqTG69/u2r88dB3POrTh28efWHrOcYLmBd50=
=vObe
-----END PGP SIGNATURE-----

--5v5ks5oi6zrb3jo2--
