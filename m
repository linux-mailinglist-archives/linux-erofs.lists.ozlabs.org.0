Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A65266E3966
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Apr 2023 16:39:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PztB94NrMz3cMf
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 00:39:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=gerry@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 303 seconds by postgrey-1.36 at boromir; Mon, 17 Apr 2023 00:39:38 AEST
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PztB25gcVz3c73
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 00:39:38 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=gerry@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VgADkIT_1681655667;
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com fp:SMTPD_---0VgADkIT_1681655667)
          by smtp.aliyun-inc.com;
          Sun, 16 Apr 2023 22:34:28 +0800
From: Gerry Liu <gerry@linux.alibaba.com>
Message-Id: <3FC47462-A324-48D0-A1E2-940BF0016113@linux.alibaba.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_332A80C8-10BD-4FC7-91B5-35AD9124BE3A"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH V3] erofs: support flattened block device for multi-blob
 images
Date: Sun, 16 Apr 2023 22:34:26 +0800
In-Reply-To: <20230302071751.48425-1-zhujia.zj@bytedance.com>
To: Jia Zhu <zhujia.zj@bytedance.com>
References: <8be37b4c-5a87-1c10-b0e6-99284e6fd4ca@linux.alibaba.com>
 <20230302071751.48425-1-zhujia.zj@bytedance.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--Apple-Mail=_332A80C8-10BD-4FC7-91B5-35AD9124BE3A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2023=E5=B9=B43=E6=9C=882=E6=97=A5 15:17=EF=BC=8CJia Zhu =
<zhujia.zj@bytedance.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> In order to support mounting multi-blobs container image as a single
> block device, add flattened block device feature for EROFS.
>=20
> In this mode, all meta/data contents will be mapped into one block
> address. User could compose a block device(by nbd/ublk/virtio-blk/
> vhost-user-blk) from multiple sources and mount the block device by
> EROFS directly. It can reduce the number of block devices used, and
> it's also benefits in both VM file passthrough and distributed storage
> scenarios.
>=20
> You can test this using the method mentioned by:
> https://github.com/dragonflyoss/image-service/pull/1111
> 1. Compose a (nbd)block device from multi-blobs.
> 2. Mount EROFS on mntdir/.
> 3. Compare the md5sum between source dir and mntdir/.
>=20
> Later, we could also use it to refer original tar blobs.
>=20
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Tested-by: Jiang Liu <gerry@linux.alibaba.com =
<mailto:gerry@alibaba.linux.com>>

> ---
> v3:
> 1. Move the flatdev check down after all sanity checks.(Jingbo Xu)
> 2. Add Reviewed-by tag.
> ---
> fs/erofs/data.c     | 8 ++++++--
> fs/erofs/internal.h | 1 +
> fs/erofs/super.c    | 5 ++++-
> 3 files changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index e16545849ea7..818f78ce648c 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -197,7 +197,6 @@ int erofs_map_dev(struct super_block *sb, struct =
erofs_map_dev *map)
> 	struct erofs_device_info *dif;
> 	int id;
>=20
> -	/* primary device by default */
> 	map->m_bdev =3D sb->s_bdev;
> 	map->m_daxdev =3D EROFS_SB(sb)->dax_dev;
> 	map->m_dax_part_off =3D EROFS_SB(sb)->dax_part_off;
> @@ -210,12 +209,17 @@ int erofs_map_dev(struct super_block *sb, struct =
erofs_map_dev *map)
> 			up_read(&devs->rwsem);
> 			return -ENODEV;
> 		}
> +		if (devs->flatdev) {
> +			map->m_pa +=3D =
blknr_to_addr(dif->mapped_blkaddr);
> +			up_read(&devs->rwsem);
> +			return 0;
> +		}
> 		map->m_bdev =3D dif->bdev;
> 		map->m_daxdev =3D dif->dax_dev;
> 		map->m_dax_part_off =3D dif->dax_part_off;
> 		map->m_fscache =3D dif->fscache;
> 		up_read(&devs->rwsem);
> -	} else if (devs->extra_devices) {
> +	} else if (devs->extra_devices && !devs->flatdev) {
> 		down_read(&devs->rwsem);
> 		idr_for_each_entry(&devs->tree, dif, id) {
> 			erofs_off_t startoff, length;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 3f3561d37d1b..4fee380a98d9 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -81,6 +81,7 @@ struct erofs_dev_context {
> 	struct rw_semaphore rwsem;
>=20
> 	unsigned int extra_devices;
> +	bool flatdev;
> };
>=20
> struct erofs_fs_context {
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 19b1ae79cec4..0afdfce372b3 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -248,7 +248,7 @@ static int erofs_init_device(struct erofs_buf =
*buf, struct super_block *sb,
> 		if (IS_ERR(fscache))
> 			return PTR_ERR(fscache);
> 		dif->fscache =3D fscache;
> -	} else {
> +	} else if (!sbi->devs->flatdev) {
> 		bdev =3D blkdev_get_by_path(dif->path, FMODE_READ | =
FMODE_EXCL,
> 					  sb->s_type);
> 		if (IS_ERR(bdev))
> @@ -290,6 +290,9 @@ static int erofs_scan_devices(struct super_block =
*sb,
> 	if (!ondisk_extradevs)
> 		return 0;
>=20
> +	if (!sbi->devs->extra_devices && !erofs_is_fscache_mode(sb))
> +		sbi->devs->flatdev =3D true;
> +
> 	sbi->device_id_mask =3D roundup_pow_of_two(ondisk_extradevs + 1) =
- 1;
> 	pos =3D le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
> 	down_read(&sbi->devs->rwsem);
> --=20
> 2.20.1


--Apple-Mail=_332A80C8-10BD-4FC7-91B5-35AD9124BE3A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">2023=E5=B9=B43=E6=9C=882=E6=97=A5 15:17=EF=BC=8CJia Zhu =
&lt;<a href=3D"mailto:zhujia.zj@bytedance.com" =
class=3D"">zhujia.zj@bytedance.com</a>&gt; =E5=86=99=E9=81=93=EF=BC=9A</di=
v><br class=3D"Apple-interchange-newline"><div class=3D""><div =
class=3D"">In order to support mounting multi-blobs container image as a =
single<br class=3D"">block device, add flattened block device feature =
for EROFS.<br class=3D""><br class=3D"">In this mode, all meta/data =
contents will be mapped into one block<br class=3D"">address. User could =
compose a block device(by nbd/ublk/virtio-blk/<br =
class=3D"">vhost-user-blk) from multiple sources and mount the block =
device by<br class=3D"">EROFS directly. It can reduce the number of =
block devices used, and<br class=3D"">it's also benefits in both VM file =
passthrough and distributed storage<br class=3D"">scenarios.<br =
class=3D""><br class=3D"">You can test this using the method mentioned =
by:<br class=3D""><a =
href=3D"https://github.com/dragonflyoss/image-service/pull/1111" =
class=3D"">https://github.com/dragonflyoss/image-service/pull/1111</a><br =
class=3D"">1. Compose a (nbd)block device from multi-blobs.<br =
class=3D"">2. Mount EROFS on mntdir/.<br class=3D"">3. Compare the =
md5sum between source dir and mntdir/.<br class=3D""><br class=3D"">Later,=
 we could also use it to refer original tar blobs.<br class=3D""><br =
class=3D"">Signed-off-by: Jia Zhu &lt;zhujia.zj@bytedance.com&gt;<br =
class=3D"">Signed-off-by: Xin Yin &lt;yinxin.x@bytedance.com&gt;<br =
class=3D"">Reviewed-by: Jingbo Xu &lt;jefflexu@linux.alibaba.com&gt;<br =
class=3D""></div></div></blockquote><div>Tested-by: Jiang Liu &lt;<a =
href=3D"mailto:gerry@alibaba.linux.com" =
class=3D"">gerry@linux.alibaba.com</a>&gt;</div><br class=3D""><blockquote=
 type=3D"cite" class=3D""><div class=3D""><div class=3D"">---<br =
class=3D"">v3:<br class=3D"">1. Move the flatdev check down after all =
sanity checks.(Jingbo Xu)<br class=3D"">2. Add Reviewed-by tag.<br =
class=3D"">---<br class=3D""> fs/erofs/data.c &nbsp;&nbsp;&nbsp;&nbsp;| =
8 ++++++--<br class=3D""> fs/erofs/internal.h | 1 +<br class=3D""> =
fs/erofs/super.c &nbsp;&nbsp;&nbsp;| 5 ++++-<br class=3D""> 3 files =
changed, 11 insertions(+), 3 deletions(-)<br class=3D""><br =
class=3D"">diff --git a/fs/erofs/data.c b/fs/erofs/data.c<br =
class=3D"">index e16545849ea7..818f78ce648c 100644<br class=3D"">--- =
a/fs/erofs/data.c<br class=3D"">+++ b/fs/erofs/data.c<br class=3D"">@@ =
-197,7 +197,6 @@ int erofs_map_dev(struct super_block *sb, struct =
erofs_map_dev *map)<br class=3D""> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>struct erofs_device_info *dif;<br =
class=3D""> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>int id;<br class=3D""><br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>/* =
primary device by default */<br class=3D""> <span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span>map-&gt;m_bdev =3D =
sb-&gt;s_bdev;<br class=3D""> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>map-&gt;m_daxdev =3D =
EROFS_SB(sb)-&gt;dax_dev;<br class=3D""> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>map-&gt;m_dax_part_off =3D =
EROFS_SB(sb)-&gt;dax_part_off;<br class=3D"">@@ -210,12 +209,17 @@ int =
erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)<br =
class=3D""> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>up_read(&amp;devs-&gt;rwsem);<br class=3D""> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>return =
-ENODEV;<br class=3D""> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>}<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if =
(devs-&gt;flatdev) {<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>map-&gt;m_pa +=3D =
blknr_to_addr(dif-&gt;mapped_blkaddr);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>up_read(&amp;devs-&gt;rwsem);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>return =
0;<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>}<br class=3D""> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>map-&gt;m_bdev =3D dif-&gt;bdev;<br class=3D""> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>map-&gt;m_daxdev =3D dif-&gt;dax_dev;<br class=3D""> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>map-&gt;m_dax_part_off =3D dif-&gt;dax_part_off;<br class=3D""> =
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>map-&gt;m_fscache =3D dif-&gt;fscache;<br class=3D""> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>up_read(&amp;devs-&gt;rwsem);<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>} else if =
(devs-&gt;extra_devices) {<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>} else if (devs-&gt;extra_devices =
&amp;&amp; !devs-&gt;flatdev) {<br class=3D""> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>down_read(&amp;devs-&gt;rwsem);<br class=3D""> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>idr_for_each_entry(&amp;devs-&gt;tree, dif, id) {<br class=3D""> =
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>erofs_off_t startoff, length;<br class=3D"">diff --git =
a/fs/erofs/internal.h b/fs/erofs/internal.h<br class=3D"">index =
3f3561d37d1b..4fee380a98d9 100644<br class=3D"">--- =
a/fs/erofs/internal.h<br class=3D"">+++ b/fs/erofs/internal.h<br =
class=3D"">@@ -81,6 +81,7 @@ struct erofs_dev_context {<br class=3D""> =
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>struct rw_semaphore rwsem;<br class=3D""><br class=3D""> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>unsigned =
int extra_devices;<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>bool flatdev;<br class=3D""> =
};<br class=3D""><br class=3D""> struct erofs_fs_context {<br =
class=3D"">diff --git a/fs/erofs/super.c b/fs/erofs/super.c<br =
class=3D"">index 19b1ae79cec4..0afdfce372b3 100644<br class=3D"">--- =
a/fs/erofs/super.c<br class=3D"">+++ b/fs/erofs/super.c<br class=3D"">@@ =
-248,7 +248,7 @@ static int erofs_init_device(struct erofs_buf *buf, =
struct super_block *sb,<br class=3D""> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (IS_ERR(fscache))<br class=3D"">=
 <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>return PTR_ERR(fscache);<br class=3D""> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>dif-&gt;fscache =3D fscache;<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>} else =
{<br class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>} else if (!sbi-&gt;devs-&gt;flatdev) {<br class=3D""> =
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>bdev =3D blkdev_get_by_path(dif-&gt;path, FMODE_READ | =
FMODE_EXCL,<br class=3D""> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span> &nbsp;sb-&gt;s_type);<br =
class=3D""> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>if (IS_ERR(bdev))<br class=3D"">@@ -290,6 +290,9 @@ static int =
erofs_scan_devices(struct super_block *sb,<br class=3D""> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if =
(!ondisk_extradevs)<br class=3D""> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>return 0;<br class=3D""><br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>if (!sbi-&gt;devs-&gt;extra_devices &amp;&amp; =
!erofs_is_fscache_mode(sb))<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>sbi-&gt;devs-&gt;flatdev =3D =
true;<br class=3D"">+<br class=3D""> <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>sbi-&gt;device_id_mask =3D =
roundup_pow_of_two(ondisk_extradevs + 1) - 1;<br class=3D""> <span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>pos =3D =
le16_to_cpu(dsb-&gt;devt_slotoff) * EROFS_DEVT_SLOT_SIZE;<br class=3D""> =
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>down_read(&amp;sbi-&gt;devs-&gt;rwsem);<br class=3D"">-- <br =
class=3D"">2.20.1<br class=3D""></div></div></blockquote></div><br =
class=3D""></body></html>=

--Apple-Mail=_332A80C8-10BD-4FC7-91B5-35AD9124BE3A--
