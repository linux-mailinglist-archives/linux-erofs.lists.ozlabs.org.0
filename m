Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FB45967E5
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Aug 2022 06:08:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M6vdj0xpdz3bk8
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Aug 2022 14:08:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=0G0VGoYe;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=coolpad.com (client-ip=101.36.218.38; helo=v03.bc.feishu.cn; envelope-from=huyue2@coolpad.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=0G0VGoYe;
	dkim-atps=neutral
X-Greylist: delayed 615 seconds by postgrey-1.36 at boromir; Wed, 17 Aug 2022 14:08:34 AEST
Received: from v03.bc.feishu.cn (v03.bc.feishu.cn [101.36.218.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4M6vdZ20vTz2xJF
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Aug 2022 14:08:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=coolpad-com.20200927.dkim.feishu.cn; t=1660708578;
  h=mime-version:from:date:message-id:subject:to;
 bh=7luP4HO9m2J2k6VfwPhn1hhkj1NNduwQZNzYHeTlBsw=;
 b=0G0VGoYe0znXo8MRj1zCeFpHPTuhV9r8xehCNw8+Xbm16Jt2RiwH1rXOn4+RFL7y6Ny+w2
 yI3rt3b4AJGe7Q1K8AtnRKKCKzoapf/A96cb/T1+rZY8e472Bp+LlkXvyipNhZCTiyCUzL
 ct0mNIW4iAR37IA3vIcDTULJcvPi6Hbi08+LydZmKlmdIOHXVun5pMeOJ4pbdgUGdAnfnR
 +lByIvw9Ocm8/l6GGzCHfmV79rZ9+f2ZB/fWrqJ9AWtbbLnfXMATgSNxmduW3a9iRYXpyC
 7pdKpVeydLb2HkZIyC3x+vu608vE3+7PAY+GDz/DSVEth11+huv8Oc0wy9ftnA==
Content-Type: multipart/alternative;
 boundary=92587a12fa4ed4e2cb3f1473505053a2133e5e6395c2a5636e1c2ca8befd
Subject: Re: [RFC PATCH v3 1/3] erofs-utils: lib: add support for fragments data decompression
Message-Id: <20220817115808.00005d00.huyue2@coolpad.com>
Mime-Version: 1.0
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
In-Reply-To: <YvvmlvbC1E2+qwFk@debian>
From: "Yue Hu" <huyue2@coolpad.com>
Date: Wed, 17 Aug 2022 11:56:08 +0800
References: <cover.1659496805.git.huyue2@coolpad.com> <013f1dc6b6c8c67482a2d554ffb60462cc8ea125.1659496805.git.huyue2@coolpad.com> <YvvmlvbC1E2+qwFk@debian>
X-Lms-Return-Path: <lba+262fc66d8+eec911+lists.ozlabs.org+huyue2@coolpad.com>
To: "Gao Xiang" <xiang@kernel.org>
Content-Transfer-Encoding: 7bit
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
Cc: linux-erofs@lists.ozlabs.org, zbestahu@163.com, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--92587a12fa4ed4e2cb3f1473505053a2133e5e6395c2a5636e1c2ca8befd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed, 17 Aug 2022 02:48:54 +0800
Gao Xiang <xiang@kernel.org> wrote:

> Hi Yue,
>=20
> I roughly look, some comments below...

Ok, i will update these in next version.

>=20
> On Wed, Aug 03, 2022 at 11:51:28AM +0800, Yue Hu wrote:
> > Add compressed fragments support for erofsfuse.
> >=20
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> >  include/erofs/internal.h |  8 ++++++++
> >  include/erofs_fs.h       | 26 ++++++++++++++++++++------
> >  lib/data.c               | 20 ++++++++++++++++++++
> >  lib/super.c              | 24 +++++++++++++++++++++++-
> >  lib/zmap.c               | 26 ++++++++++++++++++++++++++
> >  5 files changed, 97 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > index 48498fe..5980db7 100644
> > --- a/include/erofs/internal.h
> > +++ b/include/erofs/internal.h
> > @@ -102,6 +102,7 @@ struct erofs_sb_info {
> >  		u16 devt_slotoff;		/* used for mkfs */
> >  		u16 device_id_mask;		/* used for others */
> >  	};
> > +	struct erofs_inode *frags_inode; =20
>=20
> I rethought about this feature and the naming.
>=20
> I think we could name the tail (or the whole file) as a fragment.
>=20
> But I tend to name the special inode as "packed inode", since
> this special inode can be used as "compressed metadata" as well.
>=20
> So, just name as "packed_inode"?
>=20
> >  };
> > =20
> >  /* global sbi */
> > @@ -132,6 +133,7 @@ EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPA=
T_BIG_PCLUSTER)
> >  EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
> >  EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
> >  EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
> > +EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
> >  EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
> > =20
> >  #define EROFS_I_EA_INITED	(1 << 0)
> > @@ -190,6 +192,8 @@ struct erofs_inode {
> >  	void *eof_tailraw;
> >  	unsigned int eof_tailrawsize;
> > =20
> > +	erofs_off_t fragmentoff; =20
>=20
> move it to the end? or find a better place?
>=20
> > +
> >  	union {
> >  		void *compressmeta;
> >  		void *chunkindexes;
> > @@ -201,6 +205,7 @@ struct erofs_inode {
> >  			uint64_t z_tailextent_headlcn;
> >  			unsigned int    z_idataoff;
> >  #define z_idata_size	idata_size
> > +#define z_fragmentoff	fragmentoff =20
>=20
> drop this line?
>=20
> >  		};
> >  	};
> >  #ifdef WITH_ANDROID
> > @@ -276,6 +281,7 @@ enum {
> >  	BH_Mapped,
> >  	BH_Encoded,
> >  	BH_FullMapped,
> > +	BH_Fragments, =20
>=20
> 	BH_Fragment,
>=20
> >  };
> > =20
> >  /* Has a disk mapping */
> > @@ -286,6 +292,8 @@ enum {
> >  #define EROFS_MAP_ENCODED	(1 << BH_Encoded)
> >  /* The length of extent is full */
> >  #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
> > +/* Located in fragments */
> > +#define EROFS_MAP_FRAGMENTS	(1 << BH_Fragments) =20
>=20
>=20
> EROFS_MAP_FRAGMENT ?
>=20
> > =20
> >  struct erofs_map_blocks {
> >  	char mpage[EROFS_BLKSIZ];
> > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > index 08f9761..4e13566 100644
> > --- a/include/erofs_fs.h
> > +++ b/include/erofs_fs.h
> > @@ -25,13 +25,15 @@
> >  #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
> >  #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
> >  #define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
> > +#define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
> >  #define EROFS_ALL_FEATURE_INCOMPAT		\
> >  	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
> >  	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
> >  	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
> >  	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
> >  	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
> > -	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING)
> > +	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
> > +	 EROFS_FEATURE_INCOMPAT_FRAGMENTS)
> > =20
> >  #define EROFS_SB_EXTSLOT_SIZE	16
> > =20
> > @@ -73,7 +75,9 @@ struct erofs_super_block {
> >  	} __packed u1;
> >  	__le16 extra_devices;	/* # of devices besides the primary device */
> >  	__le16 devt_slotoff;	/* startoff =3D devt_slotoff * devt_slotsize */
> > -	__u8 reserved2[38];
> > +	__u8 reserved[6];
> > +	__le64 frags_nid;	/* nid of the special fragments inode */ =20
>=20
> 	packed_nid; ?
>=20
> > +	__u8 reserved2[24];
> >  };
> > =20
> >  /*
> > @@ -294,16 +298,24 @@ struct z_erofs_lzma_cfgs {
> >   * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
> >   * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
> >   * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
> > + * bit 4 : fragment pcluster (0 - off; 1 - on)
> >   */
> >  #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
> >  #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
> >  #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
> >  #define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
> > +#define Z_EROFS_ADVISE_FRAGMENT_PCLUSTER	0x0010
> > =20
> >  struct z_erofs_map_header {
> > -	__le16	h_reserved1;
> > -	/* record the size of tailpacking data */
> > -	__le16  h_idata_size;
> > +	union {
> > +		/* direct addressing for fragment offset */
> > +		__le32	h_fragmentoff;
> > +		struct {
> > +			__le16  h_reserved1;
> > +			/* record the size of tailpacking data */
> > +			__le16	h_idata_size; =20
>=20
> That is really somewhat a layout mistake when introducing
> ztailpacking feature.

Oh, we forgot to change this then.

>=20
> > +		};
> > +	};
> >  	__le16	h_advise;
> >  	/*
> >  	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
> > @@ -312,12 +324,14 @@ struct z_erofs_map_header {
> >  	__u8	h_algorithmtype;
> >  	/*
> >  	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
> > -	 * bit 3-7 : reserved.
> > +	 * bit 3-6 : reserved;
> > +	 * bit 7   : merge the whole file into fragments or not. =20
>=20
> Move the whole file into packed inode or not.
>=20
> >  	 */
> >  	__u8	h_clusterbits;
> >  };
> > =20
> >  #define Z_EROFS_VLE_LEGACY_HEADER_PADDING       8
> > +#define Z_EROFS_FRAGMENT_INODE_BIT		7 =20
>=20
> Move this forward, just before "struct z_erofs_map_header" =20
>=20
> >  /*
> >   * Fixed-sized output compression ondisk Logical Extent cluster type:
> > diff --git a/lib/data.c b/lib/data.c
> > index 6bc554d..b9dd07b 100644
> > --- a/lib/data.c
> > +++ b/lib/data.c
> > @@ -275,6 +275,26 @@ static int z_erofs_read_data(struct erofs_inode *i=
node, char *buffer,
> >  			continue;
> >  		}
> > =20
> > +		if (map.m_flags & EROFS_MAP_FRAGMENTS) {
> > +			char *out;
> > +
> > +			out =3D malloc(length - skip);
> > +			if (!out) {
> > +				ret =3D -ENOMEM;
> > +				break;
> > +			}
> > +			ret =3D z_erofs_read_data(sbi.frags_inode, out,
> > +						length - skip,
> > +						inode->z_fragmentoff + skip);
> > +			if (ret < 0) {
> > +				free(out);
> > +				break;
> > +			}
> > +			memcpy(buffer + end - offset, out, length - skip);
> > +			free(out);
> > +			continue;
> > +		}
> > +
> >  		if (map.m_plen > bufsize) {
> >  			bufsize =3D map.m_plen;
> >  			raw =3D realloc(raw, bufsize);
> > diff --git a/lib/super.c b/lib/super.c
> > index b267412..4d3ca00 100644
> > --- a/lib/super.c
> > +++ b/lib/super.c
> > @@ -104,6 +104,21 @@ int erofs_read_superblock(void)
> >  	sbi.xattr_blkaddr =3D le32_to_cpu(dsb->xattr_blkaddr);
> >  	sbi.islotbits =3D EROFS_ISLOTBITS;
> >  	sbi.root_nid =3D le16_to_cpu(dsb->root_nid);
> > +	sbi.frags_inode =3D NULL;
> > +	if (erofs_sb_has_fragments()) {
> > +		struct erofs_inode *inode;
> > +
> > +		inode =3D calloc(1, sizeof(struct erofs_inode));
> > +		if (!inode)
> > +			return -ENOMEM;
> > +		inode->nid =3D le64_to_cpu(dsb->frags_nid);
> > +		ret =3D erofs_read_inode_from_disk(inode);
> > +		if (ret) {
> > +			free(inode);
> > +			return ret;
> > +		}
> > +		sbi.frags_inode =3D inode;
> > +	}
> >  	sbi.inos =3D le64_to_cpu(dsb->inos);
> >  	sbi.checksum =3D le32_to_cpu(dsb->checksum);
> > =20
> > @@ -111,11 +126,18 @@ int erofs_read_superblock(void)
> >  	sbi.build_time_nsec =3D le32_to_cpu(dsb->build_time_nsec);
> > =20
> >  	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
> > -	return erofs_init_devices(&sbi, dsb);
> > +
> > +	ret =3D erofs_init_devices(&sbi, dsb);
> > +	if (ret && sbi.frags_inode)
> > +		free(sbi.frags_inode);
> > +	return ret;
> >  }
> > =20
> >  void erofs_put_super(void)
> >  {
> >  	if (sbi.devs)
> >  		free(sbi.devs);
> > +
> > +	if (sbi.frags_inode)
> > +		free(sbi.frags_inode);
> >  }
> > diff --git a/lib/zmap.c b/lib/zmap.c
> > index 95745c5..16267ae 100644
> > --- a/lib/zmap.c
> > +++ b/lib/zmap.c
> > @@ -83,6 +83,20 @@ static int z_erofs_fill_inode_lazy(struct erofs_inod=
e *vi)
> >  		if (ret < 0)
> >  			return ret;
> >  	}
> > +	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) {
> > +		vi->z_fragmentoff =3D le32_to_cpu(h->h_fragmentoff);
> > +
> > +		if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
> > +			vi->z_tailextent_headlcn =3D 0;
> > +		} else {
> > +			struct erofs_map_blocks map =3D { .index =3D UINT_MAX };
> > +
> > +			ret =3D z_erofs_do_map_blocks(vi, &map,
> > +						    EROFS_GET_BLOCKS_FINDTAIL);
> > +			if (ret < 0)
> > +				return ret;
> > +		}
> > +	}
> >  	vi->flags |=3D EROFS_I_Z_INITED;
> >  	return 0;
> >  }
> > @@ -546,6 +560,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode=
 *vi,
> >  				 int flags)
> >  {
> >  	bool ztailpacking =3D vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
> > +	bool infrags =3D vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER; =20
>=20
> 	inpacked;
>=20
> Thanks,
> Gao Xiang
>=20
> >  	struct z_erofs_maprecorder m =3D {
> >  		.inode =3D vi,
> >  		.map =3D map,
> > @@ -609,6 +624,9 @@ static int z_erofs_do_map_blocks(struct erofs_inode=
 *vi,
> >  		map->m_flags |=3D EROFS_MAP_META;
> >  		map->m_pa =3D vi->z_idataoff;
> >  		map->m_plen =3D vi->z_idata_size;
> > +	} else if (infrags && m.lcn =3D=3D vi->z_tailextent_headlcn) {
> > +		map->m_flags |=3D EROFS_MAP_FRAGMENTS;
> > +		DBG_BUGON(!map->m_la);
> >  	} else {
> >  		map->m_pa =3D blknr_to_addr(m.pblk);
> >  		err =3D z_erofs_get_extent_compressedlen(&m, initial_lcn);
> > @@ -652,6 +670,14 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi=
,
> >  	if (err)
> >  		goto out;
> > =20
> > +	if ((vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) &&
> > +	    !vi->z_tailextent_headlcn) {
> > +		map->m_llen =3D map->m_la + 1;
> > +		map->m_la =3D 0;
> > +		map->m_flags =3D EROFS_MAP_MAPPED | EROFS_MAP_FRAGMENTS;
> > +		goto out;
> > +	}
> > +
> >  	err =3D z_erofs_do_map_blocks(vi, map, flags);
> >  out:
> >  	DBG_BUGON(err < 0 && err !=3D -ENOMEM);
> > --=20
> > 2.17.1
> >
--92587a12fa4ed4e2cb3f1473505053a2133e5e6395c2a5636e1c2ca8befd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<p>On Wed, 17 Aug 2022 02:48:54 +0800
<br>Gao Xiang <xiang@kernel.org> wrote:
<br>
<br>> Hi Yue,
<br>>=20
<br>> I roughly look, some comments below...
<br>
<br>Ok, i will update these in next version.
<br>
<br>>=20
<br>> On Wed, Aug 03, 2022 at 11:51:28AM +0800, Yue Hu wrote:
<br>> > Add compressed fragments support for erofsfuse.
<br>> >=20
<br>> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
<br>> > ---
<br>> >  include/erofs/internal.h |  8 ++++++++
<br>> >  include/erofs_fs.h       | 26 ++++++++++++++++++++------
<br>> >  lib/data.c               | 20 ++++++++++++++++++++
<br>> >  lib/super.c              | 24 +++++++++++++++++++++++-
<br>> >  lib/zmap.c               | 26 ++++++++++++++++++++++++++
<br>> >  5 files changed, 97 insertions(+), 7 deletions(-)
<br>> >=20
<br>> > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
<br>> > index 48498fe..5980db7 100644
<br>> > --- a/include/erofs/internal.h
<br>> > +++ b/include/erofs/internal.h
<br>> > @@ -102,6 +102,7 @@ struct erofs_sb_info {
<br>> >  		u16 devt_slotoff;		/* used for mkfs */
<br>> >  		u16 device_id_mask;		/* used for others */
<br>> >  	};
<br>> > +	struct erofs_inode *frags_inode; =20
<br>>=20
<br>> I rethought about this feature and the naming.
<br>>=20
<br>> I think we could name the tail (or the whole file) as a fragment.
<br>>=20
<br>> But I tend to name the special inode as "packed inode", since
<br>> this special inode can be used as "compressed metadata" as well.
<br>>=20
<br>> So, just name as "packed_inode"?
<br>>=20
<br>> >  };
<br>> > =20
<br>> >  /* global sbi */
<br>> > @@ -132,6 +133,7 @@ EROFS_FEATURE_FUNCS(big_pcluster, incompat, INC=
OMPAT_BIG_PCLUSTER)
<br>> >  EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
<br>> >  EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
<br>> >  EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
<br>> > +EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
<br>> >  EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
<br>> > =20
<br>> >  #define EROFS_I_EA_INITED	(1 << 0)
<br>> > @@ -190,6 +192,8 @@ struct erofs_inode {
<br>> >  	void *eof_tailraw;
<br>> >  	unsigned int eof_tailrawsize;
<br>> > =20
<br>> > +	erofs_off_t fragmentoff; =20
<br>>=20
<br>> move it to the end? or find a better place?
<br>>=20
<br>> > +
<br>> >  	union {
<br>> >  		void *compressmeta;
<br>> >  		void *chunkindexes;
<br>> > @@ -201,6 +205,7 @@ struct erofs_inode {
<br>> >  			uint64_t z_tailextent_headlcn;
<br>> >  			unsigned int    z_idataoff;
<br>> >  #define z_idata_size	idata_size
<br>> > +#define z_fragmentoff	fragmentoff =20
<br>>=20
<br>> drop this line?
<br>>=20
<br>> >  		};
<br>> >  	};
<br>> >  #ifdef WITH_ANDROID
<br>> > @@ -276,6 +281,7 @@ enum {
<br>> >  	BH_Mapped,
<br>> >  	BH_Encoded,
<br>> >  	BH_FullMapped,
<br>> > +	BH_Fragments, =20
<br>>=20
<br>> 	BH_Fragment,
<br>>=20
<br>> >  };
<br>> > =20
<br>> >  /* Has a disk mapping */
<br>> > @@ -286,6 +292,8 @@ enum {
<br>> >  #define EROFS_MAP_ENCODED	(1 << BH_Encoded)
<br>> >  /* The length of extent is full */
<br>> >  #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
<br>> > +/* Located in fragments */
<br>> > +#define EROFS_MAP_FRAGMENTS	(1 << BH_Fragments) =20
<br>>=20
<br>>=20
<br>> EROFS_MAP_FRAGMENT ?
<br>>=20
<br>> > =20
<br>> >  struct erofs_map_blocks {
<br>> >  	char mpage[EROFS_BLKSIZ];
<br>> > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
<br>> > index 08f9761..4e13566 100644
<br>> > --- a/include/erofs_fs.h
<br>> > +++ b/include/erofs_fs.h
<br>> > @@ -25,13 +25,15 @@
<br>> >  #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
<br>> >  #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
<br>> >  #define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
<br>> > +#define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
<br>> >  #define EROFS_ALL_FEATURE_INCOMPAT		\
<br>> >  	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
<br>> >  	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
<br>> >  	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
<br>> >  	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
<br>> >  	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
<br>> > -	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING)
<br>> > +	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
<br>> > +	 EROFS_FEATURE_INCOMPAT_FRAGMENTS)
<br>> > =20
<br>> >  #define EROFS_SB_EXTSLOT_SIZE	16
<br>> > =20
<br>> > @@ -73,7 +75,9 @@ struct erofs_super_block {
<br>> >  	} __packed u1;
<br>> >  	__le16 extra_devices;	/* # of devices besides the primary device =
*/
<br>> >  	__le16 devt_slotoff;	/* startoff =3D devt_slotoff * devt_slotsize=
 */
<br>> > -	__u8 reserved2[38];
<br>> > +	__u8 reserved[6];
<br>> > +	__le64 frags_nid;	/* nid of the special fragments inode */ =20
<br>>=20
<br>> 	packed_nid; ?
<br>>=20
<br>> > +	__u8 reserved2[24];
<br>> >  };
<br>> > =20
<br>> >  /*
<br>> > @@ -294,16 +298,24 @@ struct z_erofs_lzma_cfgs {
<br>> >   * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
<br>> >   * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
<br>> >   * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
<br>> > + * bit 4 : fragment pcluster (0 - off; 1 - on)
<br>> >   */
<br>> >  #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
<br>> >  #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
<br>> >  #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
<br>> >  #define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
<br>> > +#define Z_EROFS_ADVISE_FRAGMENT_PCLUSTER	0x0010
<br>> > =20
<br>> >  struct z_erofs_map_header {
<br>> > -	__le16	h_reserved1;
<br>> > -	/* record the size of tailpacking data */
<br>> > -	__le16  h_idata_size;
<br>> > +	union {
<br>> > +		/* direct addressing for fragment offset */
<br>> > +		__le32	h_fragmentoff;
<br>> > +		struct {
<br>> > +			__le16  h_reserved1;
<br>> > +			/* record the size of tailpacking data */
<br>> > +			__le16	h_idata_size; =20
<br>>=20
<br>> That is really somewhat a layout mistake when introducing
<br>> ztailpacking feature.
<br>
<br>Oh, we forgot to change this then.
<br>
<br>>=20
<br>> > +		};
<br>> > +	};
<br>> >  	__le16	h_advise;
<br>> >  	/*
<br>> >  	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
<br>> > @@ -312,12 +324,14 @@ struct z_erofs_map_header {
<br>> >  	__u8	h_algorithmtype;
<br>> >  	/*
<br>> >  	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
<br>> > -	 * bit 3-7 : reserved.
<br>> > +	 * bit 3-6 : reserved;
<br>> > +	 * bit 7   : merge the whole file into fragments or not. =20
<br>>=20
<br>> Move the whole file into packed inode or not.
<br>>=20
<br>> >  	 */
<br>> >  	__u8	h_clusterbits;
<br>> >  };
<br>> > =20
<br>> >  #define Z_EROFS_VLE_LEGACY_HEADER_PADDING       8
<br>> > +#define Z_EROFS_FRAGMENT_INODE_BIT		7 =20
<br>>=20
<br>> Move this forward, just before "struct z_erofs_map_header" =20
<br>>=20
<br>> >  /*
<br>> >   * Fixed-sized output compression ondisk Logical Extent cluster ty=
pe:
<br>> > diff --git a/lib/data.c b/lib/data.c
<br>> > index 6bc554d..b9dd07b 100644
<br>> > --- a/lib/data.c
<br>> > +++ b/lib/data.c
<br>> > @@ -275,6 +275,26 @@ static int z_erofs_read_data(struct erofs_inod=
e *inode, char *buffer,
<br>> >  			continue;
<br>> >  		}
<br>> > =20
<br>> > +		if (map.m_flags & EROFS_MAP_FRAGMENTS) {
<br>> > +			char *out;
<br>> > +
<br>> > +			out =3D malloc(length - skip);
<br>> > +			if (!out) {
<br>> > +				ret =3D -ENOMEM;
<br>> > +				break;
<br>> > +			}
<br>> > +			ret =3D z_erofs_read_data(sbi.frags_inode, out,
<br>> > +						length - skip,
<br>> > +						inode->z_fragmentoff + skip);
<br>> > +			if (ret < 0) {
<br>> > +				free(out);
<br>> > +				break;
<br>> > +			}
<br>> > +			memcpy(buffer + end - offset, out, length - skip);
<br>> > +			free(out);
<br>> > +			continue;
<br>> > +		}
<br>> > +
<br>> >  		if (map.m_plen > bufsize) {
<br>> >  			bufsize =3D map.m_plen;
<br>> >  			raw =3D realloc(raw, bufsize);
<br>> > diff --git a/lib/super.c b/lib/super.c
<br>> > index b267412..4d3ca00 100644
<br>> > --- a/lib/super.c
<br>> > +++ b/lib/super.c
<br>> > @@ -104,6 +104,21 @@ int erofs_read_superblock(void)
<br>> >  	sbi.xattr_blkaddr =3D le32_to_cpu(dsb->xattr_blkaddr);
<br>> >  	sbi.islotbits =3D EROFS_ISLOTBITS;
<br>> >  	sbi.root_nid =3D le16_to_cpu(dsb->root_nid);
<br>> > +	sbi.frags_inode =3D NULL;
<br>> > +	if (erofs_sb_has_fragments()) {
<br>> > +		struct erofs_inode *inode;
<br>> > +
<br>> > +		inode =3D calloc(1, sizeof(struct erofs_inode));
<br>> > +		if (!inode)
<br>> > +			return -ENOMEM;
<br>> > +		inode->nid =3D le64_to_cpu(dsb->frags_nid);
<br>> > +		ret =3D erofs_read_inode_from_disk(inode);
<br>> > +		if (ret) {
<br>> > +			free(inode);
<br>> > +			return ret;
<br>> > +		}
<br>> > +		sbi.frags_inode =3D inode;
<br>> > +	}
<br>> >  	sbi.inos =3D le64_to_cpu(dsb->inos);
<br>> >  	sbi.checksum =3D le32_to_cpu(dsb->checksum);
<br>> > =20
<br>> > @@ -111,11 +126,18 @@ int erofs_read_superblock(void)
<br>> >  	sbi.build_time_nsec =3D le32_to_cpu(dsb->build_time_nsec);
<br>> > =20
<br>> >  	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
<br>> > -	return erofs_init_devices(&sbi, dsb);
<br>> > +
<br>> > +	ret =3D erofs_init_devices(&sbi, dsb);
<br>> > +	if (ret && sbi.frags_inode)
<br>> > +		free(sbi.frags_inode);
<br>> > +	return ret;
<br>> >  }
<br>> > =20
<br>> >  void erofs_put_super(void)
<br>> >  {
<br>> >  	if (sbi.devs)
<br>> >  		free(sbi.devs);
<br>> > +
<br>> > +	if (sbi.frags_inode)
<br>> > +		free(sbi.frags_inode);
<br>> >  }
<br>> > diff --git a/lib/zmap.c b/lib/zmap.c
<br>> > index 95745c5..16267ae 100644
<br>> > --- a/lib/zmap.c
<br>> > +++ b/lib/zmap.c
<br>> > @@ -83,6 +83,20 @@ static int z_erofs_fill_inode_lazy(struct erofs_=
inode *vi)
<br>> >  		if (ret < 0)
<br>> >  			return ret;
<br>> >  	}
<br>> > +	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) {
<br>> > +		vi->z_fragmentoff =3D le32_to_cpu(h->h_fragmentoff);
<br>> > +
<br>> > +		if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
<br>> > +			vi->z_tailextent_headlcn =3D 0;
<br>> > +		} else {
<br>> > +			struct erofs_map_blocks map =3D { .index =3D UINT_MAX };
<br>> > +
<br>> > +			ret =3D z_erofs_do_map_blocks(vi, &map,
<br>> > +						    EROFS_GET_BLOCKS_FINDTAIL);
<br>> > +			if (ret < 0)
<br>> > +				return ret;
<br>> > +		}
<br>> > +	}
<br>> >  	vi->flags |=3D EROFS_I_Z_INITED;
<br>> >  	return 0;
<br>> >  }
<br>> > @@ -546,6 +560,7 @@ static int z_erofs_do_map_blocks(struct erofs_i=
node *vi,
<br>> >  				 int flags)
<br>> >  {
<br>> >  	bool ztailpacking =3D vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUST=
ER;
<br>> > +	bool infrags =3D vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;=
 =20
<br>>=20
<br>> 	inpacked;
<br>>=20
<br>> Thanks,
<br>> Gao Xiang
<br>>=20
<br>> >  	struct z_erofs_maprecorder m =3D {
<br>> >  		.inode =3D vi,
<br>> >  		.map =3D map,
<br>> > @@ -609,6 +624,9 @@ static int z_erofs_do_map_blocks(struct erofs_i=
node *vi,
<br>> >  		map->m_flags |=3D EROFS_MAP_META;
<br>> >  		map->m_pa =3D vi->z_idataoff;
<br>> >  		map->m_plen =3D vi->z_idata_size;
<br>> > +	} else if (infrags && m.lcn =3D=3D vi->z_tailextent_headlcn) {
<br>> > +		map->m_flags |=3D EROFS_MAP_FRAGMENTS;
<br>> > +		DBG_BUGON(!map->m_la);
<br>> >  	} else {
<br>> >  		map->m_pa =3D blknr_to_addr(m.pblk);
<br>> >  		err =3D z_erofs_get_extent_compressedlen(&m, initial_lcn);
<br>> > @@ -652,6 +670,14 @@ int z_erofs_map_blocks_iter(struct erofs_inode=
 *vi,
<br>> >  	if (err)
<br>> >  		goto out;
<br>> > =20
<br>> > +	if ((vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) &&
<br>> > +	    !vi->z_tailextent_headlcn) {
<br>> > +		map->m_llen =3D map->m_la + 1;
<br>> > +		map->m_la =3D 0;
<br>> > +		map->m_flags =3D EROFS_MAP_MAPPED | EROFS_MAP_FRAGMENTS;
<br>> > +		goto out;
<br>> > +	}
<br>> > +
<br>> >  	err =3D z_erofs_do_map_blocks(vi, map, flags);
<br>> >  out:
<br>> >  	DBG_BUGON(err < 0 && err !=3D -ENOMEM);
<br>> > --=20
<br>> > 2.17.1
<br>> ></p><meta data-version=3D"editor_version_1.2.11"/><div data-zone-id=
=3D"0" data-line-index=3D"0" data-line=3D"true" style=3D"white-space: pre-w=
rap; margin-top: 4px; margin-bottom: 4px; line-height: 1.6;">------=E6=9C=
=BA=E5=AF=86=EF=BC=9A=E6=AD=A4=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E6=89=80=
=E5=8C=85=E5=90=AB=E5=86=85=E5=AE=B9=E4=B8=BA=E9=85=B7=E6=B4=BE=E6=9C=BA=E5=
=AF=86=E5=86=85=E5=AE=B9,=E5=B9=B6=E4=B8=94=E5=8F=97=E5=88=B0=E6=B3=95=E5=
=BE=8B=E7=9A=84=E4=BF=9D=E6=8A=A4=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E4=B8=
=8D=E5=B1=9E=E4=BA=8E=E4=BB=A5=E4=B8=8A=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=
=E7=9A=84=E7=9B=AE=E6=A0=87=E6=8E=A5=E6=94=B6=E8=80=85=EF=BC=8C=E6=82=A8=E4=
=B8=8D=E5=BE=97=E7=BB=86=E8=AF=BB=EF=BC=8C=E4=BD=BF=E7=94=A8=EF=BC=8C=E4=BC=
=A0=E6=92=AD=EF=BC=8C=E6=95=A3=E5=B8=83=E6=88=96=E5=A4=8D=E5=88=B6=E8=AF=A5=
=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BB=BB=E4=BD=95=E4=
=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E5=B7=B2=E7=BB=8F=E8=AF=
=AF=E6=94=B6=E6=AD=A4=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=
=E6=82=A8=E7=AB=8B=E5=8D=B3=E9=80=9A=E7=9F=A5=E6=88=91=E4=BB=AC=E5=B9=B6=E5=
=88=A0=E9=99=A4=E5=8E=9F=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E3=80=82 CONFI=
DENTIAL: This e-mail message contains information of Coolpad that is confid=
ential and which is subject to legal privilege.If you are not the intended =
recipient as indicated above,you must not peruse,use, disseminate,distribut=
e or copy any information contained in this message.If you have received th=
is message in error, please notify us and delete the original message immed=
iately.
</div><div data-zone-id=3D"0" data-line-index=3D"1" data-line=3D"true" styl=
e=3D"white-space: pre-wrap; margin-top: 4px; margin-bottom: 4px; line-heigh=
t: 1.6;">------ =E7=94=B3=E6=98=8E=EF=BC=9A=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=
=89=80=E7=8E=B0=E5=86=85=E5=AE=B9=EF=BC=8C=E4=BB=85=E4=BD=9C=E4=B8=BA=E6=88=
=91=E4=BB=AC=E4=B9=8B=E9=97=B4=E5=B0=B1=E5=90=88=E4=BD=9C=E7=9A=84=E4=BA=8B=
=E5=AE=9C=E8=BF=9B=E8=A1=8C=E7=9A=84=E4=BA=A4=E6=B5=81=E3=80=81=E6=B2=9F=E9=
=80=9A=E3=80=81=E6=B4=BD=E8=B0=88=E3=80=81=E5=95=86=E8=AE=AE=EF=BC=8C=E4=B8=
=8D=E4=BD=9C=E4=B8=BA=E5=8D=8F=E8=AE=AE=E6=88=96=E6=89=BF=E8=AF=BA=EF=BC=8C=
=E4=B8=80=E5=88=87=E5=8D=8F=E8=AE=AE=E5=8F=8A=E6=89=BF=E8=AF=BA=E5=BF=85=E9=
=A1=BB=E4=BB=A5=E4=B9=A6=E9=9D=A2=E6=96=87=E6=9C=AC=E7=9B=96=E7=AB=A0=E4=B8=
=BA=E5=87=86=E3=80=82 DECLARATION=EF=BC=9AAll contents of this E-mail ,are =
only regarded as the cooperation we have had between the exchanges, communi=
cation, negotiation and deliberation, not as a agreement or promise. All co=
ntracts and commitments must be  sealed shall prevail.
</div>
--92587a12fa4ed4e2cb3f1473505053a2133e5e6395c2a5636e1c2ca8befd--
